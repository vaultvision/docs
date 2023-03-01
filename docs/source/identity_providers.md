Identity Providers - [Vault Vision](https://vaultvision.com)
==================

## What is an Identity Provider?

An identity provider (aka an IdP) is a service that manages and provides user identity through some method of user authentication. IdPs are registered third party accounts (Google, Microsoft and Apple) that the user can use to prove their identity. The Idp becomes the central hub for that user to access other systems that know how to integrate with that IdP. Online services like Google, Microsoft and Apple maintain an available IdP for their users. This means as a user of their service, you can authenticate _to_ other 3rd party systems using Microsoft, Google and Apple account credentials. This can be convenient because the user can now use your application or service without having to complete another account registration process, they can  attach their Google or Microsoft account to your application or service. Vault Vision's platform has developed these integrations with Google, Microsoft and Apple to save you and users time. See below for steps on how to add IdP functionality to your [Vault Vision](https://vaultvision.com) account.  

## Options

	1. You can use the default Vault Vision applications at both Google and Microsoft. This will show the 'Vault Vision' brand as your users register their account with your application or service.

	#### Or

	2. You can create your own custom applications at Google and Microsoft and link them to the Vault Vision platform

## How to register as an application with Google

1. Create a Google Cloud Account
You must have a Google login, if you don't you can create one here: (https://accounts.google.com/)[https://accounts.google.com/]


2. In a browser, navigate to the Google Cloud Platform management console
(https://console.cloud.google.com)[https://console.cloud.google.com]

3. In the right hand nav menu click **APIs and Services** > **Credentials**
![Navigate to APIs and Services  Credentials](/google-ss/step1.png)

4. Now create a 'project', this is the core entity that will house your settings and give you a client id and client secret.  We will call ours 'Vault Vision Project'.  'No organization' will be just fine as a location
![Create a Project](/google-ss/step2.png)
![Enter Project Name](/google-ss/step3.png)

5. Now 'Configure Consent Screen'
![Configure Consent Screen](/google-ss/step4.png)

6. Set the User Type to 'External'
![User Type to External](/google-ss/step5.png)

7. Edit App Registration:
You will need to set the following fields:
- App name
- User support email
- App logo
- Authorized domains (You will need the (Google Search Console for this)[https://support.google.com/webmasters/answer/9008080?hl=en&ref_topic=9455938]  )
- Application home page
- Application privacy policy link
- Application terms of service link
- Developer contact information

![App Registration](/google-ss/step6.png)

8. Add the scopes needed for authentication and to get user profile data and email address
![Scope Button](/google-ss/step7.png)
Select the following scopes
- ./auth/userinfo.email
- ./auth/userinfo.profile
- openid
![Scopes](/google-ss/step8.png)

9. Add any test users you want to allow to test the integration with, these need to be real Google accounts
![Scopes](/google-ss/step9.png)

10. Return to the dashboard for the 'OAuth consent screen' and 'Publish App'
![Publish](/google-ss/step10.png)

11. Navigate to Credentials menu in the right hand nav and click 'Create Credentials' then 'OAuth client ID' to create your OAuth 2.0 Client ID and secret
![Credentials](/google-ss/step11.png)

12. Select an 'Application Type'
![App Type](/google-ss/step12.png)

13. Populate the Javascript Origins and Authorized redirect URIs

Set the Authorized JavaScript origins to the domain you used on your tenant, you can find that here at the top of the screen:
(Vault Vision Management Panel)[https://manage.vaultvision.com/go#applications]

Set Authorized redirect URIs to exactly the below:
https://callback.vvkey.io/oidc/callback

![redirect URIs](/google-ss/step13.png)


In order for Google to allow you to interact with their Google user accounts, you will need to use your 
	- ability to have and handle 2 incoming routes open to the internet over port 443
	- ability to perform 302 redirects
	- ability to set and store 4 server-side variables (client_id, client_secret, base_url, your_callback_url). Most of the time these are stored as an environment or configuration variable.
	- (optional) ability to maintain a session, this needed assuming you want users to only authenticate once and be in some kind of logged in state. This could be a cookie, session server, or session specific cache.
	- (optional in the case of using a custom domain) ability to set a DNS CNAME for your custom domain that points to nextgenauth.vaultvision.com
