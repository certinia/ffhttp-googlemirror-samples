/**
 * Copyright (c) 2014, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/
 
/**
 * GoogleMirrorAuthenticatedCallback
 *
 * Class that handles the update of the requisition, dependant on what the user has selected in Google Glass.
 */
@RestResource(urlMapping='/GoogleMirrorAuthenticatedCallback/*')
global with sharing class GoogleMirrorAuthenticatedCallback 
{
	@HttpPost
    global static void doPost(String userActionCode, String timelineItemId) 
    {
		if (String.isEmpty(userActionCode)) 
		{
			return;
		}
	
		List<GoogleMirrorItem__c> results = 
		[
			SELECT g.RelatedRecordId__c, g.Name, g.LastModifiedDate, g.Id, g.Connector__c
			FROM GoogleMirrorItem__c g
			WHERE Name =: timelineItemId
			ORDER BY LastModifiedDate DESC
		];
		
		if (results.isEmpty()) 
		{
			throw new ffhttp_AppException('Null Google Mirror Item for name: ' + timelineItemId);
		}

		GoogleMirrorItem__c mirrorItem = results[0];
		if (String.isEmpty(mirrorItem.RelatedRecordId__c)) 
		{
			throw new ffhttp_AppException('Null RelatedRecordId__c for Google Mirror Item: ' + timelineItemId);
		}
		
		Id recordId = (ID) mirrorItem.RelatedRecordId__c;
		
		List<ProcessInstanceWorkItem> workItems = 
		[
			SELECT p.Id, p.ActorId, ProcessInstance.Id, ProcessInstance.TargetObjectId, ProcessInstance.Status
 			FROM ProcessInstanceWorkitem p
			WHERE ProcessInstance.TargetObjectId =: recordId
		];
		
		if (workItems.isEmpty()) 
		{
			throw new ffhttp_AppException('Null ProcessInstanceWorkitem for TargetObjectId: ' + recordId);
		}
		
		Id workItemId = workItems[0].Id;
		
 		Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        
        if (userActionCode == GoogleMirrorApprovalProcess.USER_ACTION_CODE_APPROVE)
        {
        	req.setAction(GoogleMirrorApprovalProcess.USER_ACTION_CODE_APPROVE);
        }
        else if (userActionCode == GoogleMirrorApprovalProcess.USER_ACTION_CODE_REJECT)
        {
        	req.setAction(GoogleMirrorApprovalProcess.USER_ACTION_CODE_REJECT);
        }

        req.setWorkitemId(workItemId);
        
        Approval.ProcessResult result =  Approval.process(req);
    }
}
