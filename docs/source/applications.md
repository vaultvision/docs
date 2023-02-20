Applications - [Vault Vision](https://vaultvision.com) 
========

```{note} OAuth Client
An Application in our Vault Vision parlance is synonymous with an OAuth Client.  Our Vault Vision service provides the OAuth identity authentication for your OAuth Client Applications.
```

## Properties

**Application Name** - This name that will refer to the application you are configuring to be linked to your tenant.  It is only for management purposes and is never displayed to an end user.

**Callback URLs** - At the initiation of the user authentication process, your service will redirect a user to our login page with a special callback redirect uri that you specify in the querystring of that 302 redirect.  After our auth platform authenticates that user, we check if the callback redirect uri that was specified in the querystring matches a Callback URL set here in the Application setting screen.  If there is a match, then our auth platform will call the specified callback redirect uri and it will pass the OAuth token.  On the service handler for this callback, that is hosted on your system, you will validate that OAuth token using our token endpoint and a signed JWT with the users idenity embedded in it will be generated and returned.  This JWT can then be used to further authenticate the user in additional service calls. Usually this URL is located as something like: https://yoursite.com/auth/callback 

**Login URL** - This this the URL that our auth platform will redirect unauthenticated users to so that a new user authentication process can be initiated by your application.  The handler for this URL should generate a redirect to our authorize endpoint ('/authorize') on your tenant domain hosted on our systems.  As part of that redirect, the Application client_id and callback redirect uri need to be included in the query string.  Usually this URL is located as something like: https://yoursite.com/login 

**Logout URLs** - At the initiation of the user logout process, your service will redirect a user to our logout handler with a special callback redirect uri that you specify in the querystring of that 302 redirect.  After our auth platform ends all the sessions for that user, we check if the callback redirect uri that was specified in the querystring matches a Logout URL set here in the Application setting screen.  If there is a match, then our auth platform will call the specified callback redirect uri so that your application can finish any remaining session closures if needed.  In most cases, applications will usually remove any user sessions prior to initiating a user logout process, and in those cases, this Logout URL can simply be the home page, or whatever page you want to drop off newly logged out users.  Usually this URL is located as something like: https://yoursite.com/loggedout

## Actions

**Edit** - Using this action you can view or changes the URL and Name properties for your application.

**Delete** - This action will delete the Application and it will no longer be able to authorize or validate OAuth tokens or JWTs.
