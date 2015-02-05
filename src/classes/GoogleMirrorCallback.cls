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
 * GoogleMirrorCallback
 * 
 * Class to handle the anonymous callback from Google Glass when a requisition is approved or rejected.
 * This class passes the request to the relevant user via the GoogleMirrorAuthenticatedCallback class.
 */
@RestResource(urlMapping='/GoogleMirrorCallback/*')
global without sharing class GoogleMirrorCallback 
{
	@HttpPost
    global static void doPost(String collection, String itemId, String operation, String userToken, String verifyToken, List<UserAction> userActions) 
    {
    	String userActionCode;
        if (userActions != null 
          && !userActions.isEmpty()
		  && userActions[0].getType() == ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM)
		{
			userActionCode = userActions[0].getPayload();
		}
		
		if (String.isEmpty(userActionCode))
		{
			throw new ffhttp_AppException('Null userActionCode ' + userActionCode);
		}
		
    	ConnectorService googleConnector = getGoogleConnectorService((Id)userToken);
        if (googleConnector == null) 
        {
            throw new ffhttp_AppException('Null Google Connector for userToken: ' + userToken);
        }

		// Route the request to the appropriate Salesforce user
		Id ownerId = googleConnector.Connector.OwnerId;
		ConnectorService salesforceConnector = getSalesforceConnectorService(ownerId);
		if (salesforceConnector == null) 
        {
            throw new ffhttp_AppException('Salesforce connector not found');
        }
        
        String accessToken = salesforceConnector.getAccessToken();
		if (String.isEmpty(accessToken))
		{
			throw new ffhttp_AppException('Null accessToken for Salesforce Connector with ownerId: ' + ownerId);
		}
		
		String callbackUrl = salesforceConnector.Connector.ConnectorType__r.CallbackURL__c;
		if (String.isEmpty(callbackUrl))
		{
			throw new ffhttp_AppException('Null callbackUrl for Salesforce Connector with ownerId: ' + ownerId);
		}
	
		GoogleMirrorSalesforceService.authenticatedCallback(accessToken, callbackUrl, userActionCode, itemId);
    }

	private static ConnectorService getGoogleConnectorService(Id connectorId)
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
				WHERE c.Id = : connectorId
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
    
    private static ConnectorService getSalesforceConnectorService(Id ownerId)
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
				WHERE c.OwnerId =: ownerId
				AND ConnectorType__r.DeveloperName__c =: GoogleMirrorConfigure.GLASS_CALLBACK_TYPE_NAME
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

	/**
	 * UserAction
	 *
	 * Inner class to wrap up the UserAction information sent from Google Glass.
	 */
    global class UserAction extends ffhttp_AbstractJsonSerializable 
    {
    	private String type;
    	private String payload;
    	
    	public String getType()
    	{
    		return type;
    	}
    	public void setType(String type)
    	{
    		this.type = type;
    	}
    	public String getPayload()
    	{
    		return payload;
    	}
    	public void setPayload(String payload)
    	{
    		this.payload = payload;
    	}
    }
}
