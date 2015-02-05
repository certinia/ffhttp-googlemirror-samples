Google Mirror Sample App
========================

<a href="https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-googlemirror-samples">
    <img alt="Deploy to Salesforce"
        src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

Summary
-------

This app (or collection of apps) has been built to demonstrate the use of the [Google Mirror](https://github.com/financialforcedev/ffhttp-googlemirror) and [Core](https://github.com/financialforcedev/ffhttp-core) libraries. 

It consists of two components:

1. A test harness that provides a UI for performing all of the Google Mirror API calls.
2. An implementation of the library that shows how it can be used to create an approval process involving Google Glass.

Unlike the other sample apps (e.g. [Dropbox](https://github.com/financialforcedev/ffhttp-dropbox-samples) and [Google Drive](https://github.com/financialforcedev/ffhttp-googledrive-samples)), this app requires a lot more configuration to get it working and a little further explanation.

###Application flow
The app makes use of two extensions to the [Core](https://github.com/financialforcedev/ffhttp-core) library. The [Google Mirror](https://github.com/financialforcedev/ffhttp-googlemirror) library itself (see the calls in [GoogleMirrorService](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorService.cls)) and a simple Salesforce-to-Salesforce HTTP client (see [GoogleMirrorSalesforceService](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorSalesforceService.cls)).

After creating a requisition and submitting it for approval, a message is sent to Google Glass (via the Mirror API) to create a timeline item (see [GoogleMirrorApprovalProcess](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorApprovalProcess.cls)). At this point, the user wearing Glass can see an item in their timeline with the requisition details. Selecting this requisition in Glass gives the user the options to approve and reject it. When one of these options is selected, an anonymous API call is sent from Glass to Salesforce (see [GoogleMirrorCallback](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorCallback.cls)). This call is then directed to the appropriate user via a Salesforce-to-Salesforce API call (see [GoogleMirrorSalesforceService](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorSalesforceService.cls)). This callback is processed, updating the requisition appropriately (see [GoogleMirrorAuthenticatedCallback](https://github.com/financialforcedev/ffhttp-googlemirror/blob/master/src/classes/GoogleMirrorAuthenticatedCallback.cls))

**Note:** Currently, no test coverage for the sample apps has been provided.

Key Features
------------
+ Demonstrates each of the API calls found at https://developers.google.com/glass/v1/reference/.
+ Demonstrates the use of the [Timeline: insert](https://developers.google.com/glass/v1/reference/timeline/insert) API call to add a requisition to Google Glass.
+ Demonstrates the use of the [Subscriptions: insert](https://developers.google.com/glass/v1/reference/subscriptions/insert) API call to subscribe to changes on the Glass timeline.
+ Demonstrates the use of the [Subscriptions: delete](https://developers.google.com/glass/v1/reference/subscriptions/delete) API call to unsubscribe from changes on the Glass timeline.
+ Demonstrates the use of a callback mechanism for Salesforce-to-Salesforce API calls.

Configuration
-------------

This section explains how to configure the Google Mirror Sample App.

###Salesforce Organisation Setup

####Register Domain
1. Go to Setup > Domain Management > My Domain.
2. Enter a domain name and select **Register Domain**.
3. Make a note of your domain name as you will need this in the  **Create a Connected App** and **Deploying the project** sections e.g. https://test-ed.my.salesforce.com/
4. Go to Setup > Security Controls > Remote Site Settings.
5. Select **New Remote Site**, enter **Self Internal** as the name and the domain name as the URL.

####Sites
1. Go to Setup > Develop > Sites.
2. Enter a domain name, accept the terms of use and select **Register My Force.com Domain**.
3. Make a note of your domain name as you will need this in the **Deploying the project** section e.g. https://test-ed-developer-edition.na16.force.com/
4. Go to Setup > Security Controls > Remote Site Settings.
5. Select **New Remote Site**, enter **Self** as the name and the domain name as the URL.

####Create a Connected App
1. Go to Setup > Create Apps.
2. Select **New** in the **Connected Apps** section.
3. Enter a Connected App Name, App Name and Contact Email.
4. Select **Enable OAuth Settings**.
5. As the callback URL enter the domain name (from step 3 in the **Register Domain** section) with apex/connector appended e.g. https://test-ed.my.salesforce.com/apex/connector
6. Choose **Full access(full)** as the **Selected OAuth Scopes**.
7. Save the connected app.
8. You should be redirected to the Connected App page.
9. Make a note of the **Consumer Key** and **Consumer Secret** as you will need these in the **Deploying the project** section.

###Create a Google App

1. Log in to your Google Plus account registered to your pair of Google Glasses.
2. Go to https://console.developers.google.com/project and select Create Project.
3. Enter a project name and ok the dialog.
4. Select the hyperlink for the project name that you just created.
5. Expand the APIs & auth section.
6. Select APIs.
7. Enter Mirror in the Browse APIs section.
8. Turn the Google Mirror API on.
9. Select the Consent screen.
10. Enter a Product Name, make sure the Email Address is set and save.
11. Select Credentials.
12. Select Create new Client ID.
13. Select Web application.
14. Set the Authorized Javascript Origins url to the domain name (from step 3 in the **Register Domain** section) e.g. https://test-ed.my.salesforce.com/.
15. Set the Authorized Redirect URIs to the same as above with apex/connector appended: e.g. https://test-ed.my.salesforce.com/apex/connector.
16. Make a note of the Client Id and Client Secret as you will need these in the **Deploying the project** section.

###Deploying the project

1. Deploy the **Core**, **Google Mirror** and **OAuth Client Sample App** packages to your Salesforce organisation.
2. Deploy the **Google Mirror Sample App** to your organisation.
3. If the **Google Mirror Sample App** app shows in the app menu then go to step 9.
4. Otherwise, go to **Setup** > **Manage Users** > **Users**.
5. Select your user.
6. Select **Edit Assignments** in the **Permission Set Assignments** section.
7. Add the **Google Mirror Sample App Permissions** permission set and **Save**.
8. The **Google Mirror Sample App** project should display in the app menu. 
9. Select the **Google Mirror Sample App** project. 
    + The **Test Harness**, **Requisitions**, **Connector Types**, **Connectors** tabs should be displayed.

###Create the required Connectors in Salesforce

1. Go to the Developer Console.
2. Open the **Execute Anonymous** window from the debug menu.
3. Execute the following code from the window replacing each of the parameters with the appropriate values.

    ```
    GoogleMirrorConfigure(<ORG_DOMAIN>, <ORG_SITES_DOMAIN>, <GLASS_CLIENT_ID>, <GLASS_CLIENT_SECRET>, <GLASS_CALLBACK_CLIENT_ID>, <GLASS_CALLBACK_CLIENT_SECRET>); 
    ```

    + ORG_DOMAIN = Salesforce Organisation Setup - Registered Domain
    + ORG_SITES_DOMAIN = Salesforce Organisation Setup - Registered Site Domain
    + GLASS_CLIENT_ID = Google App Client Id
    + GLASS_CLIENT_SECRET =  Google App Client Secret
    + GLASS_CALLBACK_CLIENT_ID = Connected App Consumer Key
    + GLASS_CALLBACK_CLIENT_SECRET = Connected App Consumer Secret

4. Go to the **Connector Type** tab and check that you have two connector types: **Google Glass Approvals** and **Salesforce for Mirror Callback**.
5. Go to the **Connectors** tab and check that you have two connectors for your user e.g. **Google Glass Approvals for Joe Bloggs** and **Salesforce for Mirror Callback for Joe Bloggs**.
6. Select both connectors in turn and activate them by selecting **Activate** then **Authorize**.
7. For the **Google Glass Approvals** connector, select **Mirror Subscriptions** then **Subscribe**. This will subscribe you to the Google Glass timeline.

###Modify the Salesforce API Profile
1. Go to Setup.
2. Search for **API Profile** and select it.
3. Go to the **Enabled Apex Class Access** section and select **Edit**.
4. Add **GoogleMirrorAuthenticatedCallback** and **GoogleMirrorCallback** to the **Enabled Apex Classes** section and save.
5. Edit the profile and go to the **Custom Object Permissions** section.
6. Select **Modify All** for all the objects (Connectors, Connector Types, Google Mirror Items & Requisitions).
7. Save the profile.

Use
---
Once the project is configured:

###Test Harness
1. Select the **Test Harness** tab.
2. Check that you get a message starting with 'Successful authentication'. If you do not, check that all the configuration steps have been peformed correctly.
3. Expand any section to display the API calls, then select **Submit** to test the call.

###Google Glass Requisition Sample App

1. Create a new Requisition and save.
2. Choose to submit the requisition for approval, choosing the user that Google Glass is linked to.
3. You should be able to see the requisition in Google Glass.
4. Choosing the requisition gives you the four options: 'Read Aloud', 'Approve', 'Reject' and 'Delete'.
5. Choose to approve the requisition.
6. The record should update in Salesforce.

Reporting Issues & Enhancements
-------------------------------

Please report any issues using the github [issues](https://github.com/financialforcedev/ffhttp-googlemirror-samples/issues) feature. Suggestions / bug reports are welcome as are extensions containing additional functionality.
