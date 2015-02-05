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
 * GoogleMirrorTestHarnessController
 * 
 * Controller class for testing all the Google Mirror API calls.
 */
public class GoogleMirrorTestHarnessController
{
	//Instance variables
	public ConnectorService connectorService;
	public Boolean validConnector { get; set; }
    
    //Account Requests
    public String accountInsertRequestAccountName { get; set; }
    public String accountInsertRequestAccountType { get; set; }
    public String accountInsertRequestUserToken { get; set; } 
	public String accountInsertRequestAuthToken { get; set; }
	public String accountInsertRequestAuthTokenType { get; set; }
	public String accountInsertRequestPassword { get; set; }
	public String accountInsertRequestUserDataKey { get; set; }
	public String accountInsertRequestUserDataValue { get; set; }
	public String accountInsertRequestFeature { get; set; }
	public List<String> accountInsertRequestFeatures { get; set; }
	public List<ffhttp_GoogleMirrorModelAccount.AuthToken> accountInsertRequestAuthTokens { get; set; }
	public List<ffhttp_GoogleMirrorModelAccount.UserData> accountInsertRequestUserData { get; set; }
			
	//Contact Requests				    
    public String contactDeleteRequestContactId { get; set; }
    public String contactGetRequestContactId { get; set; }
    public String contactInsertRequestId { get; set; }
    public String contactInsertRequestDisplayName { get; set; }
    public String contactInsertRequestType { get; set; }
    public String contactInsertRequestPhoneNumber { get; set; }
    public String contactInsertRequestSpeakableName { get; set; }
    public String contactInsertRequestDummyImageUrl { get; set; }
    public String contactInsertRequestDummyAcceptType { get; set; }
    public List<String> contactInsertRequestImageUrls { get; set; }
    public List<String> contactInsertRequestAcceptCommands { get; set; }
    public List<String> contactInsertRequestAcceptTypes { get; set; }
    public Integer contactInsertRequestPriority { get; set; }  
    public String contactUpdateRequestId { get; set; }
    public String contactUpdateRequestDisplayName { get; set; }
    public String contactUpdateRequestType { get; set; }
    public String contactUpdateRequestPhoneNumber { get; set; }
    public String contactUpdateRequestSpeakableName { get; set; }
    public String contactUpdateRequestDummyImageUrl { get; set; }
    public String contactUpdateRequestDummyAcceptType { get; set; }
    public List<String> contactUpdateRequestImageUrls { get; set; }
    public List<String> contactUpdateRequestAcceptCommands { get; set; }
    public List<String> contactUpdateRequestAcceptTypes { get; set; }
    public Integer contactUpdateRequestPriority { get; set; }
    
    //Location Requests
    public String locationsGetRequestLocationId { get; set; }
    
    //Setting Requests
    public String settingsGetRequestSettingId { get; set; }
    
    //Subscription Requests
    public String subscriptionsDeleteRequestSubscriptionId { get; set; }
    public String subscriptionsInsertRequestCallbackUrl { get; set; }
    public String subscriptionsInsertRequestCollection { get; set; }
    public String subscriptionsInsertRequestUserToken { get; set; }
    public String subscriptionsInsertRequestVerifyToken { get; set; }
    public List<String> subscriptionsInsertRequestOperations { get; set; }
    public String subscriptionsUpdateRequestId { get; set; }
    public String subscriptionsUpdateRequestCallbackUrl { get; set; }
    public String subscriptionsUpdateRequestCollection { get; set; }
    public String subscriptionsUpdateRequestUserToken { get; set; }
    public String subscriptionsUpdateRequestVerifyToken { get; set; }
    public List<String> subscriptionsUpdateRequestOperations { get; set; }
    
    //Timeline Requests
    public String timelineDeleteRequestTimelineId { get; set; }
    public String timelineGetRequestTimelineId { get; set; }
    public String timelineInsertRequestUploadType { get; set; }
    public String timelineInsertRequestTitle { get; set; }
    public String timelineInsertRequestText { get; set; }
    public String timelineInsertRequestBundleId { get; set; }
	public String timelineInsertRequestCanonicalUrl { get; set; }
	public String timelineInsertRequestHtml { get; set; }
	public String timelineInsertRequestSourceItemId { get; set; }
	public String timelineInsertRequestSpeakableText { get; set; }
	public String timelineInsertRequestSpeakableType { get; set; }
    public String timelineInsertRequestMenuItemAction { get; set; }
    public String timelineInsertRequestMenuItemId { get; set; }
	public String timelineInsertRequestMenuItemPayload { get; set; }
    public String timelineInsertRequestMenuItemValueDisplayName { get; set; }
    public String timelineInsertRequestMenuItemValueIconUrl { get; set; }
    public String timelineInsertRequestMenuItemValueState { get; set; }
    public Boolean timelineInsertRequestMenuItemRemoveWhenSelected { get; set; }				     
    public Boolean timelineInsertRequestIsBundleCover { get; set; }
    public List<ffhttp_GoogleMirrorModelMenuItem> timelineInsertRequestMenuItems { get; set; }
    public List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue> timelineInsertRequestMenuItemValues { get; set; }
    public String timelineListRequestBundleId { get; set; }
	public String timelineListRequestPageToken { get; set; }
	public String timelineListRequestSourceItemId { get; set; }
	public Integer timelineListRequestMaxResults { get; set; }
	public Boolean timelineListRequestIncludeDeleted { get; set; }
	public Boolean timelineListRequestPinnedOnly { get; set; }
	public String timelineListRequestOrderByType { get; set; }
    public String timelineUpdateRequestId { get; set; }
    public String timelineUpdateRequestUploadType { get; set; }
    public String timelineUpdateRequestTitle { get; set; }
    public String timelineUpdateRequestText { get; set; }
    public String timelineUpdateRequestBundleId { get; set; }
	public String timelineUpdateRequestCanonicalUrl { get; set; }
	public String timelineUpdateRequestHtml { get; set; }
	public String timelineUpdateRequestSourceItemId { get; set; }
	public String timelineUpdateRequestSpeakableText { get; set; }
	public String timelineUpdateRequestSpeakableType { get; set; }
    public String timelineUpdateRequestMenuItemAction { get; set; }
    public String timelineUpdateRequestMenuItemId { get; set; }
	public String timelineUpdateRequestMenuItemPayload { get; set; }
    public String timelineUpdateRequestMenuItemValueDisplayName { get; set; }
    public String timelineUpdateRequestMenuItemValueIconUrl { get; set; }
    public String timelineUpdateRequestMenuItemValueState { get; set; }
    public Boolean timelineUpdateRequestMenuItemRemoveWhenSelected { get; set; }				     
    public Boolean timelineUpdateRequestIsBundleCover { get; set; }
    public List<ffhttp_GoogleMirrorModelMenuItem> timelineUpdateRequestMenuItems { get; set; }
    public List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue> timelineUpdateRequestMenuItemValues { get; set; }
     	
    //Timeline attachment requests
    public String timelineAttachmentsDeleteRequestTimelineId { get; set; }
    public String timelineAttachmentsDeleteRequestAttachmentId { get; set; }
    public String timelineAttachmentsDownloadRequestURL { get; set; }
    public String timelineAttachmentsDownloadRequestContentType { get; set; }
    public String timelineAttachmentsDownloadRequestFileBody { get; set; }
    public String timelineAttachmentsGetRequestTimelineId { get; set; }
    public String timelineAttachmentsGetRequestAttachmentId { get; set; }
    public String timelineAttachmentsInsertRequestTimelineId { get; set; }
    public String timelineAttachmentsInsertRequestUploadType { get; set; }
    public String timelineAttachmentsInsertRequestFileName { get; set; }
    public String timelineAttachmentsInsertRequestFileContentType { get; set; }
    public String timelineAttachmentsListRequestTimelineId { get; set; }
    
    //Files associated with requests. 
    //Declared transient as they should not be saved to the ViewState.
    public transient Blob timelineAttachmentsInsertRequestFileBody { get; set; }
    
    /**
     * Constructors
     */
    public GoogleMirrorTestHarnessController()
    {
       	this.connectorService = getConnectorService();
        this.init();
        this.initialiseLists();
    }
    
    private void init()
   	{
        if (connectorService != null)
        {
        	String msg = connectorService.validateConnector();
        	validConnector = String.isEmpty(msg);
        	if (!validConnector)
        	{
        		error(msg);
        	}
        	else
        	{
        		info('Successful authentication. The \'' + connectorService.Connector.Name + '\' connector is being used for authentication.');
        	}
        }
        else
        {
        	error('Google Cloud Print connector not found.');
        }
   	}
   	
   	private void initialiseLists()
    {
    	accountInsertRequestAuthTokens = new List<ffhttp_GoogleMirrorModelAccount.AuthToken>();
    	accountInsertRequestUserData = new List<ffhttp_GoogleMirrorModelAccount.UserData>();
		accountInsertRequestFeatures = new List<String>();
	
    	contactInsertRequestImageUrls = new List<String>();
    	contactInsertRequestAcceptCommands = new List<String>();
   	 	contactInsertRequestAcceptTypes = new List<String>();
    	contactUpdateRequestImageUrls = new List<String>();
   		contactUpdateRequestAcceptCommands = new List<String>();
   	 	contactUpdateRequestAcceptTypes = new List<String>();
   	
   		subscriptionsInsertRequestOperations = new List<String>();
   		subscriptionsUpdateRequestOperations = new List<String>();
   		
    	timelineInsertRequestMenuItems = new List<ffhttp_GoogleMirrorModelMenuItem>();
   		timelineInsertRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
   		timelineUpdateRequestMenuItems = new List<ffhttp_GoogleMirrorModelMenuItem>();
   		timelineUpdateRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
    }
   	
   	/**
     * Gets a valid connector for Google requests.
     *
     * Note: for separation of concerns consider using a selector pattern.
	 * See https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Selector_Layer
     */
    private ConnectorService getConnectorService()
    {
    	if (connectorService == null)
    	{	
    		try
    		{
	    		Connector__c c = 
	    		[
	    			SELECT 
	    				c.TokenType__c, c.RefreshToken__c, c.RefreshTokenRequested__c, c.Name, c.Id, c.AccessToken__c, 
					   	c.AccessTokenRequested__c, c.AccessTokenExpiry__c, c.Active__c, 
					   	ConnectorType__r.TokenEndpoint__c, ConnectorType__r.Scope__c, ConnectorType__r.ScopeRequired__c, 
					   	ConnectorType__r.RedirectUri__c, ConnectorType__r.Name, ConnectorType__r.Id, 
					   	ConnectorType__r.ExtraUrlParameters__c, ConnectorType__r.DeveloperName__c, 
					   	ConnectorType__r.ClientSecret__c, ConnectorType__r.ClientId__c, ConnectorType__r.CallbackURL__c, 
					   	ConnectorType__r.AuthorizationEndpoint__c
	    			FROM Connector__c c
	    			WHERE ConnectorType__r.Name =: GoogleMirrorConfigure.GLASS_TYPE_LABEL
	    			AND c.OwnerId =: UserInfo.getUserID()
	    			LIMIT 1
	    		];
	    		
	    		if (c != null)
	    		{
	    			connectorService = new ConnectorService(c);
	    		}
    		}
    		catch (Exception ex)
    		{
    		}
    	}
    	return connectorService;
    }
    
    /**
     * Account Requests
     */
    public void accountInsertRequest()
    {
    	ffhttp_GoogleMirrorAccounts accounts = createGoogleMirrorAccounts();
    	if (accounts == null)
    	{
    		return;
    	}
    	
		if (stringValueNotSet('Accounts', 'Account Name', accountInsertRequestAccountName)
		  || stringValueNotSet('Accounts', 'Account Type', accountInsertRequestAccountType)
		  || stringValueNotSet('Accounts', 'User Token', accountInsertRequestUserToken))
        {
        	return;
        }
    	
    	ffhttp_GoogleMirrorModelAccount account = new ffhttp_GoogleMirrorModelAccount();
    	account.setAccountName(accountInsertRequestAccountName);
    	account.setAccountType(accountInsertRequestAccountType);
		account.setUserToken(accountInsertRequestUserToken);
		
		account.setAuthTokens(accountInsertRequestAuthTokens);
		account.setPassword(accountInsertRequestPassword);
		account.setFeatures(accountInsertRequestFeatures);
		account.setUserData(accountInsertRequestUserData);
		
		ffhttp_GoogleMirrorAccounts.InsertRequest request = accounts.insertRequest(account);
		execute(request);
    }
    
    public ffhttp_GoogleMirrorAccounts createGoogleMirrorAccounts()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
       	ffhttp_GoogleMirror gm = createGoogleMirror();
        return (ffhttp_GoogleMirrorAccounts)gm.accounts();    
    }
    
    public void accountInsertRequestAddAuthToken()
    {
    	if (stringValueNotSet('Accounts', 'Auth Token', accountInsertRequestAuthToken)
		  || stringValueNotSet('Accounts', 'Auth Token Type', accountInsertRequestAuthTokenType))
        {
        	return;
        }
    	
    	ffhttp_GoogleMirrorModelAccount.AuthToken authToken = new ffhttp_GoogleMirrorModelAccount.AuthToken();
    	authToken.setAuthToken(accountInsertRequestAuthToken);
    	authToken.setType(accountInsertRequestAuthTokenType);
    	accountInsertRequestAuthTokens.add(authToken);
		
		accountInsertRequestAuthToken = null;
		accountInsertRequestAuthTokenType = null;
    }
    
    public void accountInsertRequestAddUserData()
    {
    	if (stringValueNotSet('Accounts', 'User Data Key', accountInsertRequestUserDataKey)
		  || stringValueNotSet('Accounts', 'User Data Value', accountInsertRequestUserDataValue))
        {
        	return;
        }
    	
    	ffhttp_GoogleMirrorModelAccount.UserData userData = new ffhttp_GoogleMirrorModelAccount.UserData();
    	userData.setKey(accountInsertRequestUserDataKey);
    	userData.setValue(accountInsertRequestUserDataValue);
    	accountInsertRequestUserData.add(userData);
		
		accountInsertRequestUserDataKey = null;
		accountInsertRequestUserDataValue = null;
    }
    
    public void accountInsertRequestAddFeature()
    {
    	if (stringValueNotSet('Accounts', 'Feature', accountInsertRequestFeature))
        {
        	return;
        }
    	
    	accountInsertRequestFeatures.add(accountInsertRequestFeature);
    	
    	accountInsertRequestFeature = null;
    }
    
    /**
     * Contact Requests
     */
    public void contactsDeleteRequest()
    {
    	ffhttp_GoogleMirrorContacts contacts = createGoogleMirrorContacts();
    	if (contacts == null)
    	{
    		return;
    	}
    
    	if (stringValueNotSet('Contacts', 'Id', contactDeleteRequestContactId))
        {
        	return;
        }
    
        ffhttp_GoogleMirrorContacts.DeleteRequest request = contacts.deleteRequest(contactDeleteRequestContactId);
        execute(request);
    }
    
    public void contactsGetRequest()
    {
    	ffhttp_GoogleMirrorContacts contacts = createGoogleMirrorContacts();
    	if (contacts == null)
    	{
    		return;
    	}
    
    	if (stringValueNotSet('Contacts', 'Id', contactGetRequestContactId))
        {
        	return;
        }

        ffhttp_GoogleMirrorContacts.GetRequest request = contacts.getRequest(contactGetRequestContactId);
        execute(request);
    }
    
    public void contactsInsertRequest()
    {
    	ffhttp_GoogleMirrorContacts contacts = createGoogleMirrorContacts();
    	if (contacts == null)
    	{
    		return;
    	}
    	
    	if (contactInsertRequestAcceptCommands.size() == 0)
    	{
    		error('You must choose at least one accept command');
    		return;
    	}
    	
    	List<ffhttp_GoogleMirrorModelContact.AcceptCommand> acceptCommands = new List<ffhttp_GoogleMirrorModelContact.AcceptCommand>();
    	for (String acceptCommandType : contactInsertRequestAcceptCommands)
    	{
    		acceptCommands.add(new ffhttp_GoogleMirrorModelContact.AcceptCommand().setType(acceptCommandType));
    	}
        
        ffhttp_GoogleMirrorModelContact contact = new ffhttp_GoogleMirrorModelContact();
    	contact.setAcceptCommands(acceptCommands);
    	contact.setAcceptTypes(contactInsertRequestAcceptTypes);
    	contact.setDisplayName(contactInsertRequestDisplayName);
    	contact.setId(contactInsertRequestId);
    	contact.setImageUrls(contactInsertRequestImageUrls);
    	contact.setPhoneNumber(contactInsertRequestPhoneNumber);
    	contact.setPriority(contactInsertRequestPriority);
    	contact.setSpeakableName(contactInsertRequestSpeakableName);
    	contact.setType(contactInsertRequestType);
    	
    	ffhttp_GoogleMirrorContacts.InsertRequest request = contacts.insertRequest(contact);
        execute(request);
    }
    
    public void contactInsertRequestAddImageUrl()
    {
    	if (stringValueNotSet('Contacts', 'Image URL', contactInsertRequestDummyImageUrl))
        {
        	return;
        }
   		
   		contactInsertRequestImageUrls.add(contactInsertRequestDummyImageUrl);
   		contactInsertRequestDummyImageUrl = null;
    }
    
    public void contactInsertRequestAddAcceptType()
    {
    	if (stringValueNotSet('Contacts', 'Accept Type', contactInsertRequestDummyAcceptType))
        {
        	return;
        }
   		
   		contactInsertRequestAcceptTypes.add(contactInsertRequestDummyAcceptType);
   		contactInsertRequestDummyAcceptType = null;
    }
    
    public void contactUpdateRequestAddImageUrl()
    {
    	if (stringValueNotSet('Contacts', 'Image URL', contactUpdateRequestDummyImageUrl))
        {
        	return;
        }
        
   		contactUpdateRequestImageUrls.add(contactUpdateRequestDummyImageUrl);
   		contactUpdateRequestDummyImageUrl = null;
    }
    
    public void contactUpdateRequestAddAcceptType()
    {
    	if (stringValueNotSet('Contacts', 'Accept Type', contactUpdateRequestDummyAcceptType))
        {
        	return;
        }
   		
   		contactUpdateRequestAcceptTypes.add(contactUpdateRequestDummyAcceptType);
   		contactUpdateRequestDummyAcceptType = null;
    }
    
    public void contactsListRequest()
    {
    	ffhttp_GoogleMirrorContacts contacts = createGoogleMirrorContacts();
    	if (contacts == null)
    	{
    		return;
    	}
        
        ffhttp_GoogleMirrorContacts.ListRequest request = contacts.listRequest();
        execute(request);
    }
    
    public void contactsUpdateRequest()
    {
    	ffhttp_GoogleMirrorContacts contacts = createGoogleMirrorContacts();
    	if (contacts == null)
    	{
    		return;
    	}
    	
    	if (contactUpdateRequestAcceptCommands.size() == 0)
    	{
    		error('You must choose at least one accept command');
    		return;
    	}
    	
    	List<ffhttp_GoogleMirrorModelContact.AcceptCommand> acceptCommands = new List<ffhttp_GoogleMirrorModelContact.AcceptCommand>();
    	for (String acceptCommandType : contactUpdateRequestAcceptCommands)
    	{
    		acceptCommands.add(new ffhttp_GoogleMirrorModelContact.AcceptCommand().setType(acceptCommandType));
    	}
    	
    	ffhttp_GoogleMirrorModelContact contact = new ffhttp_GoogleMirrorModelContact();
    	contact.setAcceptCommands(acceptCommands);
    	contact.setAcceptTypes(contactUpdateRequestAcceptTypes);
    	contact.setDisplayName(contactUpdateRequestDisplayName);
    	contact.setId(contactUpdateRequestId);
    	contact.setImageUrls(contactUpdateRequestImageUrls);
    	contact.setPhoneNumber(contactUpdateRequestPhoneNumber);
    	contact.setPriority(contactUpdateRequestPriority);
    	contact.setSpeakableName(contactUpdateRequestSpeakableName);
    	contact.setType(contactUpdateRequestType);
    	
    	ffhttp_GoogleMirrorContacts.UpdateRequest request = contacts.updateRequest(contact);
        execute(request);
    }   
    
    public ffhttp_GoogleMirrorContacts createGoogleMirrorContacts()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
        ffhttp_GoogleMirror gm = createGoogleMirror();
        return (ffhttp_GoogleMirrorContacts)gm.contacts();    
    }
    
    /**
     * Location Requests
     */
    public void locationsGetRequest()
    {
    	ffhttp_GoogleMirrorLocations locations = createGoogleMirrorLocations();
    	if (locations == null)
    	{
    		return;
    	}
    	
    	if (stringValueNotSet('Locations', 'Id', locationsGetRequestLocationId))
        {
        	return;
        }
    
        ffhttp_GoogleMirrorLocations.GetRequest request = locations.getRequest(locationsGetRequestLocationId);
        execute(request);   
    }
    
    public void locationsListRequest()
    {
    	ffhttp_GoogleMirrorLocations locations = createGoogleMirrorLocations();
    	if (locations == null)
    	{
    		return;
    	}
    	
    	ffhttp_GoogleMirrorLocations.ListRequest request = locations.listRequest();
        execute(request);
    } 
    
    public ffhttp_GoogleMirrorLocations createGoogleMirrorLocations()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
        ffhttp_GoogleMirror gm = createGoogleMirror();
        return (ffhttp_GoogleMirrorLocations)gm.locations();
    }

    /**
     * Setting Requests
     */   
    public void settingsGetRequest()
    {
    	ffhttp_GoogleMirrorSettings settings = createGoogleMirrorSettings();
    	if (settings == null
    	  || stringValueNotSet('Settings', 'Id', settingsGetRequestSettingId))
    	{
    		return;
    	}
    	
    	ffhttp_GoogleMirrorSettings.GetRequest getRequest = settings.getRequest(settingsGetRequestSettingId);
    	execute(getRequest);
    }
    
    public ffhttp_GoogleMirrorSettings createGoogleMirrorSettings()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
       	ffhttp_GoogleMirror gm = createGoogleMirror();
        return (ffhttp_GoogleMirrorSettings)gm.settings();
    }
    
    /**
     * Subscription Requests
     */
    public void subscriptionsDeleteRequest()
    {
    	ffhttp_GoogleMirrorSubscriptions subscriptions = createGoogleMirrorSubscriptions();
    	if (subscriptions == null
    	 || stringValueNotSet('Subscriptions', 'Id', subscriptionsDeleteRequestSubscriptionId))
    	{
    		return;
    	}
    
        ffhttp_GoogleMirrorSubscriptions.DeleteRequest request = subscriptions.deleteRequest(subscriptionsDeleteRequestSubscriptionId);
        execute(request);
    } 
    
    public void subscriptionsInsertRequest()
    {
    	ffhttp_GoogleMirrorSubscriptions subscriptions = createGoogleMirrorSubscriptions();
    	if (subscriptions == null
    	 || stringValueNotSet('Subscriptions', 'Callback URL', subscriptionsInsertRequestCallbackUrl)
    	 || stringValueNotSet('Subscriptions', 'Collection', subscriptionsInsertRequestCollection))
    	{
    		return;
    	}
    	
    	ffhttp_GoogleMirrorModelSubscription subscription = new ffhttp_GoogleMirrorModelSubscription();
    	subscription.setCallbackUrl(subscriptionsInsertRequestCallbackUrl);
    	subscription.setCollection(subscriptionsInsertRequestCollection);
    	subscription.setOperation(subscriptionsInsertRequestOperations);
    	subscription.setUserToken(subscriptionsInsertRequestUserToken);
    	subscription.setVerifyToken(subscriptionsInsertRequestVerifyToken);
    	
    	ffhttp_GoogleMirrorSubscriptions.InsertRequest request = subscriptions.insertRequest(subscription);
        execute(request);
    }
    
    public void subscriptionsListRequest()
    {
    	ffhttp_GoogleMirrorSubscriptions subscriptions = createGoogleMirrorSubscriptions();
    	if (subscriptions == null)
    	{
    		return;
    	}
    	
        ffhttp_GoogleMirrorSubscriptions.ListRequest request = subscriptions.listRequest();
        execute(request);
    } 
   
   	public void subscriptionsUpdateRequest()
    {
    	ffhttp_GoogleMirrorSubscriptions subscriptions = createGoogleMirrorSubscriptions();
    	if (subscriptions == null
    	 || stringValueNotSet('Subscriptions', 'Id', subscriptionsUpdateRequestId)
    	 || stringValueNotSet('Subscriptions', 'Callback URL', subscriptionsUpdateRequestCallbackUrl)
    	 || stringValueNotSet('Subscriptions', 'Collection', subscriptionsUpdateRequestCollection))
    	{
    		return;
    	}
    	
    	ffhttp_GoogleMirrorModelSubscription subscription = new ffhttp_GoogleMirrorModelSubscription();
    	subscription.setId(subscriptionsUpdateRequestId);
    	subscription.setCallbackUrl(subscriptionsUpdateRequestCallbackUrl);
    	subscription.setCollection(subscriptionsUpdateRequestCollection);
    	subscription.setOperation(subscriptionsUpdateRequestOperations);
    	subscription.setUserToken(subscriptionsUpdateRequestUserToken);
    	subscription.setVerifyToken(subscriptionsUpdateRequestVerifyToken);
    	
        ffhttp_GoogleMirrorSubscriptions.UpdateRequest request = subscriptions.updateRequest(subscription);
        execute(request);
    }
    
    private ffhttp_GoogleMirrorSubscriptions createGoogleMirrorSubscriptions()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
    	ffhttp_GoogleMirror gm = createGoogleMirror();
        return gm.subscriptions();
    }
    
    /**
     * Timeline Requests
     */
    public void timelineDeleteRequest()
    {
    	ffhttp_GoogleMirrorTimeline timeline = createGoogleMirrorTimeline();
        if (timeline == null
         || stringValueNotSet('Timeline', 'Id', timelineDeleteRequestTimelineId))
        {
        	return;
        }
           
        ffhttp_GoogleMirrorTimeline.DeleteRequest request = timeline.deleteRequest(timelineDeleteRequestTimelineId);
        execute(request);
    }
    
    public void timelineGetRequest()
    {
    	ffhttp_GoogleMirrorTimeline timeline = createGoogleMirrorTimeline();
        if (timeline == null
         || stringValueNotSet('Timeline', 'Id', timelineGetRequestTimelineId))
        {
        	return;
        }
  
        ffhttp_GoogleMirrorTimeline.GetRequest request = timeline.getRequest(timelineGetRequestTimelineId);
        execute(request);
    }
    
    public void timelineInsertRequest()
    {
    	ffhttp_GoogleMirrorTimeline timeline = createGoogleMirrorTimeline();
        if (timeline == null)
        {
        	return;
        }
    	
    	ffhttp_GoogleMirrorModelTimeline timelineItem = new ffhttp_GoogleMirrorModelTimeline();
    	timelineItem.setBundleId(timelineInsertRequestBundleId);
    	timelineItem.setCanonicalUrl(timelineInsertRequestCanonicalUrl);
    	timelineItem.setHtml(timelineInsertRequestHtml);
    	timelineItem.setIsBundleCover(timelineInsertRequestIsBundleCover);
    	timelineItem.setSourceItemId(timelineInsertRequestSourceItemId);
    	timelineItem.setSpeakableText(timelineInsertRequestSpeakableText);
    	timelineItem.setSpeakableType(timelineInsertRequestSpeakableType);
    	timelineItem.setTitle(timelineInsertRequestTitle);
    	timelineItem.setText(timelineInsertRequestText);
    	timelineItem.setMenuItems(timelineInsertRequestMenuItems);
    	
    	ffhttp_GoogleMirrorTimeline.InsertRequest request = timeline.insertRequest(timelineItem);
        execute(request);
    }
    
    public void timelineListRequest()
    {
        ffhttp_GoogleMirrorTimeline timeline = createGoogleMirrorTimeline();
        if (timeline == null)
        {
        	return;
        }
        
        ffhttp_GoogleMirrorTimeline.ListRequest request = (ffhttp_GoogleMirrorTimeline.ListRequest)timeline.listRequest();
        
        if (!String.isEmpty(timelineListRequestBundleId))
		{
			request.setBundleId(timelineListRequestBundleId);	
		}
		
		if (!String.isEmpty(timelineListRequestPageToken))
		{
			request.setPageToken(timelineListRequestPageToken);
		}
		
		if (!String.isEmpty(timelineListRequestSourceItemId))
		{
			request.setSourceItemId(timelineListRequestSourceItemId);
		}
		
		if (timelineListRequestMaxResults != null 
		  && timelineListRequestMaxResults > 0)
		{
			request.setMaxResults(timelineListRequestMaxResults);
		}
		
		if (timelineListRequestIncludeDeleted != null)
		{
			request.setIncludeDeleted(timelineListRequestIncludeDeleted);
		}
		
		if (timelineListRequestPinnedOnly != null)
		{
			request.setPinnedOnly(timelineListRequestPinnedOnly);
		}
		
		if (!String.isEmpty(timelineListRequestOrderByType))
		{
			request.setOrderBy(timelineListRequestOrderByType);
		}
        
        execute(request);
    }
    
    public void timelineUpdateRequest()
    {
    	ffhttp_GoogleMirrorTimeline timeline = createGoogleMirrorTimeline();
        if (timeline == null)
        {
        	return;
        }
    	
    	if (stringValueNotSet('Timeline', 'Id', timelineUpdateRequestId))
    	{
    		return;
    	}
    	
    	ffhttp_GoogleMirrorModelTimeline timelineItem = new ffhttp_GoogleMirrorModelTimeline();
    	timelineItem.setId(timelineUpdateRequestId);
    	timelineItem.setBundleId(timelineUpdateRequestBundleId);
    	timelineItem.setCanonicalUrl(timelineUpdateRequestCanonicalUrl);
    	timelineItem.setHtml(timelineUpdateRequestHtml);
    	timelineItem.setIsBundleCover(timelineUpdateRequestIsBundleCover);
    	timelineItem.setSourceItemId(timelineUpdateRequestSourceItemId);
    	timelineItem.setSpeakableText(timelineUpdateRequestSpeakableText);
    	timelineItem.setSpeakableType(timelineUpdateRequestSpeakableType);
    	timelineItem.setTitle(timelineUpdateRequestTitle);
    	timelineItem.setText(timelineUpdateRequestText);
    	timelineItem.setMenuItems(timelineUpdateRequestMenuItems);
    	
    	ffhttp_GoogleMirrorTimeline.UpdateRequest request = timeline.updateRequest(timelineItem);
        execute(request);
    }
    
    public ffhttp_GoogleMirrorTimeline createGoogleMirrorTimeline()
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
    	
        ffhttp_GoogleMirror gm = createGoogleMirror();
        return gm.timeline();
    }
    
    public void timelineInsertRequestMenuItemAdd()
    {
    	if (stringValueNotSet('Timeline', 'Menu Item Action', timelineInsertRequestMenuItemAction))
    	{
    		return;
    	}
    	
    	if (timelineInsertRequestMenuItemAction.equals(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM)
    	  && timelineInsertRequestMenuItemValues.isEmpty())
    	{
    		error('For custom menu items you must add some menu item values.');
    		return;
    	}
    	
    	if (!timelineInsertRequestMenuItemAction.equals(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM)
    	  && !timelineInsertRequestMenuItemValues.isEmpty())
    	{
    		error('For non-custom menu items you cannot add values');
    		timelineInsertRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
    		return;
    	}
    	
    	ffhttp_GoogleMirrorModelMenuItem menuItem = new ffhttp_GoogleMirrorModelMenuItem();
    	menuItem.setAction(timelineInsertRequestMenuItemAction);
    	menuItem.setId(timelineInsertRequestMenuItemId);
		menuItem.setPayload(timelineInsertRequestMenuItemPayload);
		menuItem.setRemoveWhenSelected(timelineInsertRequestMenuItemRemoveWhenSelected);
		menuItem.setValues(new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>(timelineInsertRequestMenuItemValues));
		
		timelineInsertRequestMenuItems.add(menuItem);		    	
   	
   		timelineInsertRequestMenuItemAction = null;
   		timelineInsertRequestMenuItemId = null;
   		timelineInsertRequestMenuItemPayload = null;
   		timelineInsertRequestMenuItemRemoveWhenSelected = false;
   		timelineInsertRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
    }
    
    public void timelineInsertRequestMenuItemValueAdd()
    {
    	ffhttp_GoogleMirrorModelMenuItem.MenuItemValue value = new ffhttp_GoogleMirrorModelMenuItem.MenuItemValue();
    	value.setDisplayName(timelineInsertRequestMenuItemValueDisplayName);
		value.setIconUrl(timelineInsertRequestMenuItemValueIconUrl);
		value.setState(timelineInsertRequestMenuItemValueState);
		
		timelineInsertRequestMenuItemValues.add(value);
		
		timelineInsertRequestMenuItemValueDisplayName = null;
		timelineInsertRequestMenuItemValueIconUrl = null;
		timelineInsertRequestMenuItemValueState = null;
    }
    
    public void timelineUpdateRequestMenuItemAdd()
    {
    	if (stringValueNotSet('Timeline', 'Menu Item Action', timelineUpdateRequestMenuItemAction))
    	{
    		return;
    	}
    	
    	if (timelineUpdateRequestMenuItemAction.equals(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM)
    	  && timelineUpdateRequestMenuItemValues.isEmpty())
    	{
    		error('For custom menu items you must add some menu item values.');
    		return;
    	}
    	
    	if (!timelineUpdateRequestMenuItemAction.equals(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM)
    	  && !timelineUpdateRequestMenuItemValues.isEmpty())
    	{
    		error('For non-custom menu items you cannot add values');
    		timelineUpdateRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
    		return;
    	}
    	
    	ffhttp_GoogleMirrorModelMenuItem menuItem = new ffhttp_GoogleMirrorModelMenuItem();
    	menuItem.setAction(timelineUpdateRequestMenuItemAction);
    	menuItem.setId(timelineUpdateRequestMenuItemId);
		menuItem.setPayload(timelineUpdateRequestMenuItemPayload);
		menuItem.setRemoveWhenSelected(timelineUpdateRequestMenuItemRemoveWhenSelected);
		menuItem.setValues(new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>(timelineUpdateRequestMenuItemValues));
		
		timelineUpdateRequestMenuItems.add(menuItem);		    	
   	
   		timelineUpdateRequestMenuItemAction = null;
   		timelineUpdateRequestMenuItemId = null;
   		timelineUpdateRequestMenuItemPayload = null;
   		timelineUpdateRequestMenuItemRemoveWhenSelected = false;
   		timelineUpdateRequestMenuItemValues = new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>();
    }
    
    public void timelineUpdateRequestMenuItemValueAdd()
    {
    	ffhttp_GoogleMirrorModelMenuItem.MenuItemValue value = new ffhttp_GoogleMirrorModelMenuItem.MenuItemValue();
    	value.setDisplayName(timelineUpdateRequestMenuItemValueDisplayName);
		value.setIconUrl(timelineUpdateRequestMenuItemValueIconUrl);
		value.setState(timelineUpdateRequestMenuItemValueState);
		
		timelineUpdateRequestMenuItemValues.add(value);
		
		timelineUpdateRequestMenuItemValueDisplayName = null;
		timelineUpdateRequestMenuItemValueIconUrl = null;
		timelineUpdateRequestMenuItemValueState = null;
    }
    
    /**
     * Timeline Attachment Requests
     */
    public void timelineAttachmentsDeleteRequest()
    {
    	if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsDeleteRequestTimelineId))
        {
            return;
        }
        
    	ffhttp_GoogleMirrorTimelineAttachments timelineAttachments = createGoogleMirrorTimelineAttachments(timelineAttachmentsDeleteRequestTimelineId);
        if (timelineAttachments == null)
        {
        	return;
        }
        
        if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsDeleteRequestAttachmentId))
        {
        	return;
        }
        
        ffhttp_GoogleMirrorTimelineAttachments.DeleteRequest request = timelineAttachments.deleteRequest(timelineAttachmentsDeleteRequestAttachmentId);
        execute(request);
    }
    
    public void timelineAttachmentsDownloadRequest()
    {	
    	ffhttp_GoogleMirrorTimelineAttachments timelineAttachments = createGoogleMirrorTimelineAttachments('Download');
        if (timelineAttachments == null)
        {
        	return;
        }
        
        if (stringValueNotSet('Timeline Attachments', 'URL', timelineAttachmentsDownloadRequestURL)
          || stringValueNotSet('Timeline Attachments', 'Content Type', timelineAttachmentsDownloadRequestContentType))
        {
        	error('URL must be set.');
        	return;
        }
        
      	ffhttp_GoogleMirrorModelAttachment attachment = new ffhttp_GoogleMirrorModelAttachment();
		attachment.setContentType(timelineAttachmentsDownloadRequestContentType);
		attachment.setContentUrl(timelineAttachmentsDownloadRequestURL);
		
        ffhttp_GoogleMirrorTimelineAttachments.DownloadRequest request = timelineAttachments.downloadRequest(attachment);
      	HttpResponse response = request.executeUnparsed();
        timelineAttachmentsDownloadRequestFileBody = EncodingUtil.base64Encode(response.getBodyAsBlob());
        info('Select the \'View Attachment\' to view the file');
    }
    
    public PageReference timelineAttachmentsDownloadRequestViewAttachment()
    {	
    	if (String.isEmpty(timelineAttachmentsDownloadRequestContentType)
    	  || String.isEmpty(timelineAttachmentsDownloadRequestFileBody))
    	{
    		error('You must submit a download request before you can view the file.');
    		return null;  
    	}
    	
    	String url = String.format('data:{0};content-disposition:attachment;base64,{1}', 
    							   new List<String>
    							   {
    							       timelineAttachmentsDownloadRequestContentType,
    							       timelineAttachmentsDownloadRequestFileBody
    							   });
    	
    	return new PageReference(url);
    }        
    
    public void timelineAttachmentsGetRequest()
    {
    	if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsGetRequestTimelineId))
        {
            return;
        }
        
    	ffhttp_GoogleMirrorTimelineAttachments timelineAttachments = createGoogleMirrorTimelineAttachments(timelineAttachmentsGetRequestTimelineId);
        if (timelineAttachments == null)
        {
        	return;
        }
        
        if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsGetRequestAttachmentId))
        {
        	return;
        }
        
        ffhttp_GoogleMirrorTimelineAttachments.GetRequest request = timelineAttachments.getRequest(timelineAttachmentsGetRequestAttachmentId);
        execute(request);
    }
        
    public void timelineAttachmentsInsertRequest()
    {
    	if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsInsertRequestTimelineId))
        {
            return;
        }
        
    	ffhttp_GoogleMirrorTimelineAttachments timelineAttachments = createGoogleMirrorTimelineAttachments(timelineAttachmentsInsertRequestTimelineId);
        if (timelineAttachments == null)
        {
        	return;
        }
        
        if (stringValueNotSet('Timeline Attachments', 'Upload Type', timelineAttachmentsInsertRequestUploadType))
        {
        	return;
        }
        
        if (String.isEmpty(timelineAttachmentsInsertRequestFileName)
          || timelineAttachmentsInsertRequestFileBody == null
          || timelineAttachmentsInsertRequestFileContentType == null)
        {
        	error('You must select a file.');
        	return;
        }
        
        ffhttp_GoogleMirrorTimelineAttachments.InsertRequest request = timelineAttachments.insertRequest(timelineAttachmentsInsertRequestFileBody, timelineAttachmentsInsertRequestFileContentType);
        execute(request);
    }
    
    public void timelineAttachmentsListRequest()
    {	
    	if (stringValueNotSet('Timeline Attachments', 'Id', timelineAttachmentsListRequestTimelineId))
        {
            return;
        }
        
    	ffhttp_GoogleMirrorTimelineAttachments timelineAttachments = createGoogleMirrorTimelineAttachments(timelineAttachmentsListRequestTimelineId);
        if (timelineAttachments == null)
        {
        	return;
        }
        
        ffhttp_GoogleMirrorTimelineAttachments.ListRequest request = timelineAttachments.listRequest();
        execute(request);
    }
    
    public ffhttp_GoogleMirrorTimelineAttachments createGoogleMirrorTimelineAttachments(String timelineId)
    {
    	if (!checkAuthorized())
    	{
    		return null;
    	}
        
        ffhttp_GoogleMirror gm = createGoogleMirror();
        return new ffhttp_GoogleMirrorTimelineAttachments(gm, timelineId);   
    }
    
    private ffhttp_GoogleMirror createGoogleMirror()
    {
    	String tokenType = connectorService.connector.TokenType__c;
    	String accessToken = connectorService.connector.AccessToken__c;
    	
    	ffhttp_Client.Credentials credentials = new ffhttp_Client.Credentials(tokenType, accessToken);
        return new ffhttp_GoogleMirror(credentials);	
    }
    
    /**
     * Helper methods
     */
    private void error(String message) 
    {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
    }
    
    private void info(String message) 
    {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, message));
    }
    
    private void execute(ffhttp_Client.AbstractClientRequest request) 
    {
        try
        {
            HttpRequest httpRequest = request.buildHttpRequest();
            
            String body = httpRequest.getBody();
            Blob b = httpRequest.getBodyAsBlob();
            if (b != null)
            {
            	body = 'Body consists of blob data';
            }
            
            request.buildHttpRequest();
            
            info('Request: Endpoint: ' + httpRequest.getEndpoint() + ' Body: ' + body);
        
            HttpResponse response = request.executeUnparsed();
            info('Response: Status: ' + response.getStatus() + ' Body: ' + response.getBody());
        }
        catch (Exception ex)
        {
            error('Error whilst processing request: ' + ex.getMessage());
        }    
    }
    
    private Boolean checkAuthorized()
	{
		if (connectorService == null)
		{
			return false;
		}
		
		String validConnector = connectorService.validateConnector();
		if (!String.isEmpty(validConnector))
		{
			error(validConnector);
		}
		
		return String.isEmpty(validConnector);
	}
	
	private Boolean stringValueNotSet(String calloutSection, String name, String value)
	{
		if (String.isEmpty(value))
		{
			error(calloutSection + ': ' + name + ' must be set.');
			return true;
		}
		return false;
	}
     
 	/**
 	 * List methods
 	 */
    public List<SelectOption> getSubscriptionCollections() 
    {
    	List<SelectOption> options = new List<SelectOption>();
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.COLLECTION_TIMELINE, ffhttp_GoogleMirrorModelSubscription.COLLECTION_TIMELINE));
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.COLLECTION_LOCATIONS, ffhttp_GoogleMirrorModelSubscription.COLLECTION_LOCATIONS));
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.COLLECTION_SETTINGS, ffhttp_GoogleMirrorModelSubscription.COLLECTION_SETTINGS));
    	return options;
    }
   	public List<SelectOption> getSubscriptionOperations() 
    {
    	List<SelectOption> options = new List<SelectOption>();
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.OPERATION_DELETE, 'Delete'));
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.OPERATION_INSERT, 'Insert'));
    	options.add(new SelectOption(ffhttp_GoogleMirrorModelSubscription.OPERATION_UPDATE, 'Update'));
    	return options;
    }
   	public List<SelectOption> getTimelineUploadTypes() 
    {
    	List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MEDIA, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MEDIA));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MULTIPART, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MULTIPART));
        //options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_RESUMABLE, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_RESUMABLE));
        return options;
   	}
   	public List<SelectOption> getTimelineAttachmentUploadTypes()
   	{
   		List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MEDIA, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MEDIA));
       	//options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MULTIPART, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_MULTIPART));
        //options.add(new SelectOption(ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_RESUMABLE, ffhttp_GoogleMirrorModelAbstractObject.UPLOAD_TYPE_RESUMABLE));
        return options;
   	}
    public List<SelectOption> getTimelineMenuItemActions()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM, 'Custom'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_REPLY, 'Reply'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_REPLY_ALL, 'Reply All'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_DELETE, 'Delete'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_SHARE, 'Share'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_OPEN_URI, 'Open Uri'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_PLAY_VIDEO, 'Play Video'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_READ_ALOUD, 'Read Aloud')); 
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_VOICE_CALL, 'Voice call')); 
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_NAVIGATE, 'Navigate'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_TOGGLE_PINNED, 'Toggle Pinned'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_SEND_MESSAGE, 'Send Message'));
		options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_GET_MEDIA_INPUT, 'Get Media Input'));
		return options;	
	}
    public List<SelectOption> getTimelineMenuItemValueStates()
    {
		List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_VALUE_STATE_DEFAULT, 'Default'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_VALUE_STATE_PENDING, 'Pending'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_VALUE_STATE_CONFIRMED, 'Confirmed'));
        return options;
    }
    public List<SelectOption> getContactTypes()
    { 
    	List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelContact.TYPE_INDIVIDUAL, 'Individual'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelContact.TYPE_GROUP, 'Group'));
        return options;
    }
    public List<SelectOption> getContactAcceptCommandTypes()
    { 
    	List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorModelContact.ACCEPT_COMMAND_TAKE_A_NOTE, 'Take a note'));
        options.add(new SelectOption(ffhttp_GoogleMirrorModelContact.ACCEPT_COMMAND_POST_AN_UPDATE, 'Post an update'));
        return options;
    }
    public List<SelectOption> getTimelineListOrderByTypes()
    { 
    	List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(ffhttp_GoogleMirrorTimeline.ORDER_BY_DISPLAY_TIME, 'Display Time'));
        options.add(new SelectOption(ffhttp_GoogleMirrorTimeline.ORDER_BY_WRITE_TIME, 'Write Time'));
        return options;
    }
}
