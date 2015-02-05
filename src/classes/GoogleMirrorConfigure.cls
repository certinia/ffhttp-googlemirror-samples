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
 * GoogleMirrorConfigure
 *
 * Configuration class to make it easier to create the configuration for Google Mirror.
 * This class creates both the Google Mirror and Salesforce connectors.
 */
public with sharing class GoogleMirrorConfigure
{	
	//Statics
	public static final String GLASS_TYPE_NAME = 'GoogleMirror';
	public static final String GLASS_CALLBACK_TYPE_NAME = 'SalesforceMirrorCallback';
	
	public static final String GLASS_TYPE_LABEL = 'Google Mirror API';
	public static final String GLASS_CALLBACK_TYPE_LABEL = 'Salesforce for Mirror Callback';
		
	private static String s_orgDomain;
	private static String s_orgSitesDomain;
	private static String s_glassClientId;
	private static String s_glassClientSecret;
	private static String s_glassCallbackClientId;
	private static String s_glassCallbackClientSecret;

	public static void configure(String orgDomain, String orgSitesDomain, String glassClientId, String glassClientSecret,
								 String glassCallbackClientId, String glassCallbackClientSecret) 
	{
		configure(orgDomain, orgSitesDomain, glassClientId, glassClientSecret, glassCallbackClientId, 
			 	  glassCallbackClientSecret, false);
	}	
	
	public static void configure(String orgDomain, String orgSitesDomain, String glassClientId, String glassClientSecret,
								 String glassCallbackClientId, String glassCallbackClientSecret, Boolean purge) 
	{
		s_orgDomain = orgDomain;
		s_orgSitesDomain = orgSitesDomain;
		s_glassClientId = glassClientId;
		s_glassClientSecret = glassClientSecret;
		s_glassCallbackClientId = glassCallbackClientId;
		s_glassCallbackClientSecret = glassCallbackClientSecret;
		
		if (purge) 
		{
			purgeAll();
		}
		
		connectorTypes();
		connectors();
	}

	public static void purgeAll()
	{
		delete [SELECT id FROM Connector__c];
		delete [SELECT id FROM ConnectorType__c];
		delete [SELECT id FROM Requisition__c];
		delete [SELECT id FROM GoogleMirrorItem__c];
	}

	static void connectorTypes() 
	{
		List<ConnectorType__c> connectorTypes = [SELECT Name, DeveloperName__c FROM ConnectorType__c];
		List<ConnectorType__c> newConnectorTypes = new List<ConnectorType__c>();
		
		ConnectorType__c callbackConnectorType;
		ConnectorType__c glassConnectorType;

		for (ConnectorType__c item : connectorTypes) 
		{
			if (item.DeveloperName__c==GLASS_CALLBACK_TYPE_NAME)
			{
				callbackConnectorType = item;
			}
			if (item.DeveloperName__c==GLASS_TYPE_NAME)
			{
				glassConnectorType = item;
			}
		}
		
		if (callbackConnectorType==null) 
		{
			newConnectorTypes.add(new ConnectorType__c(
				Name=GLASS_CALLBACK_TYPE_LABEL,
				DeveloperName__c=GLASS_CALLBACK_TYPE_NAME,
				AuthorizationEndpoint__c='https://login.salesforce.com/services/oauth2/authorize',
				TokenEndpoint__c='https://login.salesforce.com/services/oauth2/token',
				ClientId__c=s_glassCallbackClientId,
				ClientSecret__c=s_glassCallbackClientSecret,
				RedirectUri__c=s_orgDomain + '/apex/connector',
				Scope__c='',
				ScopeRequired__c=false,
				ExtraUrlParameters__c='',
				CallbackURL__c=s_orgDomain + '/services/apexrest/mdw/GoogleMirrorAuthenticatedCallback/'
			) );
		}
				
		if (glassConnectorType==null) 
		{
			newConnectorTypes.add(new ConnectorType__c(
				Name=GLASS_TYPE_LABEL,
				DeveloperName__c=GLASS_TYPE_NAME,
				AuthorizationEndpoint__c='https://accounts.google.com/o/oauth2/auth',
				TokenEndpoint__c='https://accounts.google.com/o/oauth2/token',
				ClientId__c=s_glassClientId,
				ClientSecret__c=s_glassClientSecret,
				RedirectUri__c=s_orgDomain + '/apex/connector',
				ScopeRequired__c=true,
				Scope__c='https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/glass.timeline',
				ExtraUrlParameters__c='access_type=offline&approval_prompt=force',
				CallbackURL__c=s_orgSitesDomain + '/api/services/apexrest/mdw/GoogleMirrorCallback/'
			));
		}
				
		insert newConnectorTypes;
	}
	
	static void connectors() 
	{	
		Id glassConnectorTypeId;
		Id callbackConnectorTypeId;
		
		for (ConnectorType__c item : [SELECT id,DeveloperName__c FROM ConnectorType__c]) 
		{
			if (item.DeveloperName__c==GLASS_TYPE_NAME)
			{
				glassConnectorTypeId = item.id;
			}
			else if (item.DeveloperName__c==GLASS_CALLBACK_TYPE_NAME)
			{
				callbackConnectorTypeId = item.id;
			}
		}
		
		List<User> internalUsers = [SELECT id, Name FROM User WHERE UserType='Standard' AND IsActive=true];

		ConnectorCollection existingConnectors = new ConnectorCollection();

		for (Connector__c item : [SELECT OwnerId, ConnectorType__r.DeveloperName__c FROM Connector__c]) 
		{
			existingConnectors.add(item.OwnerId, item.ConnectorType__r.DeveloperName__c);
		}
		
		List<Connector__c> newConnectors = new List<Connector__c>();

		for (User internalUser : internalUsers) 
		{
			if (!existingConnectors.has(internalUser.Id,GLASS_CALLBACK_TYPE_NAME)) 
			{
				newConnectors.add(new Connector__c(
					OwnerId = internalUser.Id,
					Name = GLASS_CALLBACK_TYPE_LABEL + ' for ' + internalUser.Name,
					ConnectorType__c = callbackConnectorTypeId
				));
			}
			
			if (!existingConnectors.has(internalUser.Id,GLASS_TYPE_NAME)) 
			{
				newConnectors.add(new Connector__c(
					OwnerId = internalUser.Id,
					Name = GLASS_TYPE_LABEL + ' for ' + internalUser.Name,
					ConnectorType__c = glassConnectorTypeId
				));
			}
		}
		
		insert newConnectors;		
	}
	
	class ConnectorCollection 
	{
		Map<Id,Set<String>> state = new Map<Id,Set<String>>();
		
		void add(Id userId, String typeName) 
		{
			Set<String> typeNames = state.get(userId);
			if (typeNames==null) 
			{
				typeNames = new Set<String>();
				state.put(userId,typeNames);
			}
			
			typeNames.add(typeName);
		}
		
		boolean has(Id userId, String typeName) 
		{
			return (state.get(userId) == null) ? false : state.get(userId).contains(typeName);
		}
	}
}
