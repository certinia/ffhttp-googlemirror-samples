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
 * GoogleMirrorSubscribeController
 *
 * Class to handle subscribing a connector to the Glass timeline.
 */
public with sharing class GoogleMirrorSubscribeController 
{
	private ConnectorService m_connectorService;
	
	private ffhttp_GoogleMirrorModelSubscription.ItemList m_listResponse;

	public Boolean canSubscribe { get; set;}

	public GoogleMirrorSubscribeController(ApexPages.StandardController controller) 
	{
		Connector__c c = (Connector__c)
		[
			SELECT c.TokenType__c, c.RefreshToken__c, c.RefreshTokenRequested__c, c.OwnerId, c.Name, 
				   c.Id, c.Active__c, c.AccessToken__c, c.AccessTokenRequested__c, c.AccessTokenExpiry__c,
				   ConnectorType__r.TokenEndpoint__c, ConnectorType__r.Scope__c, ConnectorType__r.ScopeRequired__c, 
				   ConnectorType__r.RedirectUri__c,  ConnectorType__r.Name, 
				   ConnectorType__r.Id, ConnectorType__r.ExtraUrlParameters__c, ConnectorType__r.DeveloperName__c, 
				   ConnectorType__r.CreatedDate, ConnectorType__r.CreatedById, ConnectorType__r.ClientSecret__c, 
				   ConnectorType__r.ClientId__c, ConnectorType__r.CallbackURL__c, ConnectorType__r.AuthorizationEndpoint__c
			FROM Connector__c c
			WHERE c.Id = :controller.getId()
			LIMIT 1
		];
		
		if (c.ConnectorType__r.DeveloperName__c == GoogleMirrorConfigure.GLASS_TYPE_NAME) 
		{
			try 
			{
				m_connectorService = new ConnectorService(c);
				String accessToken = m_connectorService.getAccessToken();
				m_listResponse = GoogleMirrorService.getSubscriptions(accessToken);
				canSubscribe = true;
			}
			catch(Exception e)
			{
				error(e.getMessage());
			}
		}
		else
		{
			error('This connector type doesn\'t have subscriptions');
			canSubscribe = false;
		}
	}
	
	public PageReference subscribe() 
	{
		try 
		{
			String accessToken = m_connectorService.getAccessToken();
			ffhttp_GoogleMirrorModelSubscription newSub = GoogleMirrorService.subscribe(accessToken, m_connectorService.connector);
			m_listResponse = GoogleMirrorService.getSubscriptions(accessToken);
			info('Successfully subscribed to the ' + newSub.getCollection() + ' collection');
		}
		catch(Exception e) 
		{
			error(e.getMessage());
		}
		
		return null;
	}
	
	public PageReference unsubscribe() 
	{
		try 
		{
			String accessToken = m_connectorService.getAccessToken();
			GoogleMirrorService.unsubscribe(accessToken);
			info('Successfully unsubscribed');
			m_listResponse = GoogleMirrorService.getSubscriptions(accessToken);
		}
		catch (Exception e) 
		{
			error(e.getMessage());
		}
		
		return null;
	}
	
	public List<ffhttp_GoogleMirrorModelSubscription> getSubscriptions() 
	{
		return m_listResponse==null ? new List<ffhttp_GoogleMirrorModelSubscription>() : (List<ffhttp_GoogleMirrorModelSubscription>)m_listResponse.getItems();
	}

	void error(String message) 
	{
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
	}

	void info(String message) 
	{
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, message));
	}
}
