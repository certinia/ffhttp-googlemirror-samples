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
 * GoogleMirrorApprovalProcess
 *
 * Class to handle the submission of a requisition to Google Glass when the approval process is initiated. 
 */
public with sharing class GoogleMirrorApprovalProcess 
{
	public static final String USER_ACTION_CODE_APPROVE = 'Approve';
	public static final String USER_ACTION_CODE_REJECT = 'Reject';
	
	public static final String STATUS_SUBMITTED = 'Submitted';
	
	/**
	 * Constructor
	 */
	public GoogleMirrorApprovalProcess()
	{
	}
	
	/**
	 * Consider bulkification of this method.
	 */
	public void afterUpdate(List<SObject> triggerNew, Map<Id,SObject> triggerOldMap) 
	{ 
		for (SObject item : triggerNew) 
		{
			Id itemId = item.Id;
			SObject oldItem = triggerOldMap.get(itemId);
			
			String newStatus = (String)item.get('ApprovalStatus__c'); 
			String oldStatus = (String) oldItem.get('ApprovalStatus__c'); 
			
			if (newStatus == STATUS_SUBMITTED 
			  && oldStatus != STATUS_SUBMITTED) 
			{
				processSubmitted(itemId);
			}
		}
	}

	@future(callout=true) 
	static void processSubmitted(String actionId) 
	{	
		ProcessInstanceWorkItem workItem = getProcessWorkItem(actionId);	
		if (workItem == null)
		{	
			throw new ffhttp_AppException('Null workItem for actionId: ' + actionId);
		}
		
		String actorId = workItem.ActorId;
		ConnectorService cs = getConnectorService(actorId);
		if (cs == null)
		{
			throw new ffhttp_AppException('Null Google Connector for actorId: ' + actorId);
		}
		
		String accessToken = cs.getAccessToken();
		if (String.isEmpty(accessToken))
		{
			throw new ffhttp_AppException('Null accessToken for Connector with actorId: ' + actorId);
		}
		
		String targetObjectId = workItem.ProcessInstance.TargetObjectId;
		Requisition__c requisition = getRequisition(targetObjectId);
		if (requisition == null)
		{
			throw new ffhttp_AppException('Null requisition for targetObjectId: ' + targetObjectId);
		}
		
		String message = 'Requisition Approval:\n' + requisition.Name + '\n$' + requisition.Budget__c;
		ffhttp_GoogleMirrorModelTimeline response = GoogleMirrorService.insertApprovalTimelineItem(accessToken, message);
		insert new GoogleMirrorItem__c(Name=response.getId(), Connector__c=cs.Connector.Id, RelatedRecordId__c=requisition.Id);
	}
	
	private static ConnectorService getConnectorService(String actorId)
    {
    	ConnectorService retval = null;
    	
 		try
    	{
    		Connector__c c = 
    		[
	    		SELECT 
					c.TokenType__c, c.RefreshToken__c, c.RefreshTokenRequested__c, c.OwnerId, 
					c.Name, c.Id, c.Active__c, c.AccessToken__c, c.AccessTokenRequested__c, c.AccessTokenExpiry__c,
					ConnectorType__r.TokenEndpoint__c, ConnectorType__r.Scope__c, ConnectorType__r.ScopeRequired__c, 
					ConnectorType__r.RedirectUri__c, ConnectorType__r.OwnerId, ConnectorType__r.Name, 
					ConnectorType__r.Id, ConnectorType__r.ExtraUrlParameters__c, ConnectorType__r.DeveloperName__c, 
					ConnectorType__r.ClientSecret__c, ConnectorType__r.ClientId__c, ConnectorType__r.CallbackURL__c, 
					ConnectorType__r.AuthorizationEndpoint__c
				FROM Connector__c c
				WHERE c.OwnerId = :actorId 
				AND ConnectorType__r.DeveloperName__c = :GoogleMirrorConfigure.GLASS_TYPE_NAME
				LIMIT 1
    		];
    		
    		if (c != null)
    		{
    			ConnectorService cs = new ConnectorService(c);
    			String validConnector = cs.validateConnector();
    			if (String.isEmpty(validConnector))
    			{
    				retval = cs;
    			}
    		}
		}
		catch (Exception ex)
		{
			//Ignore errors - we deal with them elsewhere
		}

		return retval;
    }
    
    private static ProcessInstanceWorkItem getProcessWorkItem(String actionId)
   	{
   		ProcessInstanceWorkItem retval = null;
   		
   		try
		{
			retval = 
			[
				SELECT p.Id, p.ActorId, ProcessInstance.Id, ProcessInstance.TargetObjectId, ProcessInstance.Status
				FROM ProcessInstanceWorkitem p
				WHERE ProcessInstance.TargetObjectId = :actionId
				LIMIT 1
			];
		}
		catch (Exception ex)
		{
			//Ignore errors - we deal with them elsewhere
		}
		
		return retval;
   	}
   	
   	private static Requisition__c getRequisition(String targetId)
   	{	
		Requisition__c retval = null;
		
		try
		{
			retval =
			[
				SELECT Name, Budget__c 
				FROM Requisition__c 
				WHERE Id = :targetId
			];
		} 
		catch (Exception ex)
		{
			//Ignore errors - we deal with them elsewhere
		}
		
		return retval;
   	}		
}
