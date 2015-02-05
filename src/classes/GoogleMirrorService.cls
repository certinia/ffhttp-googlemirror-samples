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
 * GoogleMirrorService
 *
 * Class containing the calls to Google Glass.
 */
public with sharing class GoogleMirrorService 
{	
	public static ffhttp_GoogleMirrorModelSubscription.ItemList getSubscriptions(String accessToken) 
	{
		ffhttp_GoogleMirrorSubscriptions.ListRequest req = createGoogleMirrorSubscriptions(accessToken).listRequest();
		return (ffhttp_GoogleMirrorModelSubscription.ItemList) req.execute();		
	}

	public static ffhttp_GoogleMirrorModelSubscription subscribe(String accessToken, Connector__c connector) 
	{
		return subscribe(connector.Id, 'myVerifyToken', connector.ConnectorType__r.CallbackURL__c, accessToken);
	}	
	
	public static ffhttp_GoogleMirrorModelSubscription subscribe(String userToken, String verifyToken, String callbackUrl, String accessToken) 
	{
		ffhttp_GoogleMirrorModelSubscription subscription = new ffhttp_GoogleMirrorModelSubscription();
		subscription.setCollection('timeline');
		subscription.setUserToken(userToken);
		subscription.setVerifyToken(verifyToken);
		subscription.setCallbackUrl(callbackUrl);
		
		ffhttp_GoogleMirrorSubscriptions.InsertRequest req = createGoogleMirrorSubscriptions(accessToken).insertRequest(subscription);
		return (ffhttp_GoogleMirrorModelSubscription) req.execute();
	}

	public static void unsubscribe(String accessToken) 
	{
		ffhttp_GoogleMirrorSubscriptions.DeleteRequest req = createGoogleMirrorSubscriptions(accessToken).deleteRequest('timeline');
		req.execute();
	}

	public static ffhttp_GoogleMirrorModelTimeline insertApprovalTimelineItem(String accessToken, String textMessage) 
	{
		ffhttp_GoogleMirrorModelTimeline timelineItem = new ffhttp_GoogleMirrorModelTimeline();
		timelineItem.setText(textMessage);
		timelineItem.setNotification(new ffhttp_GoogleMirrorModelTimeline.Notification());

		List<ffhttp_GoogleMirrorModelMenuItem> menuItems = new List<ffhttp_GoogleMirrorModelMenuItem> 
		{
			new ffhttp_GoogleMirrorModelMenuItem().setAction(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_READ_ALOUD),
			new ffhttp_GoogleMirrorModelMenuItem().setAction(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM).setId('approve').setValues(new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>{new ffhttp_GoogleMirrorModelMenuItem.MenuItemValue().setDisplayName('Approve').setState(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_VALUE_STATE_DEFAULT)}),
			new ffhttp_GoogleMirrorModelMenuItem().setAction(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_CUSTOM).setId('reject').setValues(new List<ffhttp_GoogleMirrorModelMenuItem.MenuItemValue>{new ffhttp_GoogleMirrorModelMenuItem.MenuItemValue().setDisplayName('Reject').setState(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_VALUE_STATE_DEFAULT)}),
			new ffhttp_GoogleMirrorModelMenuItem().setAction(ffhttp_GoogleMirrorModelMenuItem.MENU_ITEM_ACTION_DELETE)
		};
		timelineItem.setMenuItems(menuItems);

		ffhttp_GoogleMirrorTimeline.InsertRequest req = createGoogleMirrorTimeline(accessToken).insertRequest(timelineItem);
		return (ffhttp_GoogleMirrorModelTimeline)req.execute();
	}
	
	private static ffhttp_GoogleMirrorSubscriptions createGoogleMirrorSubscriptions(String accessToken)
	{
		ffhttp_GoogleMirror gm = createGoogleMirror(accessToken);
		return gm.subscriptions();
	}
	
	private static ffhttp_GoogleMirrorTimeline createGoogleMirrorTimeline(String accessToken)
	{
		ffhttp_GoogleMirror gm = createGoogleMirror(accessToken);
		return gm.timeline();
	}
		
	private static ffhttp_GoogleMirror createGoogleMirror(String accessToken)
	{
		ffhttp_Client.Credentials credentials = new ffhttp_Client.Credentials('Bearer', accessToken);
		return new ffhttp_GoogleMirror(credentials);
	}
}
