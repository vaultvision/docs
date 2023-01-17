Reference - Vault Vision
==================

## Typical OIDC Application to User Auth Provider Flow Diagrams

When implementing an OIDC Application to integrate with an Auth Provider, there are the following 6 flows to consider. 2 flows each for: signup, login, logout

- User starting a signup from the Application
- User starting a login from the Application
- User starting a logout from the Application
- Auth Provider redirecting the user back to the Application with the OIDC authentication payload after a successful signup or login
- Auth Provider redirecting the user back to the Application after a successful logout
- Auth Provider redirecting the user back to the Application when the Auth Provider did not receive the proper login request.  The Auth Provider needs to know a URL on the Application where the user can see a login button and can restart a user login request



## Step 1

Decide the URL locations for these 3 endpoints on your website:

- callback (route location on your website where our services will redirect authenticated users to with an OAuth token)
  - Usually something like: https://yoursite.com/callback
- login (route location on your website where we will redirect unauthenticated users to so that you can redirect them back with the proper login intitation request paramters, like your client_id and callback URL)
  - Usually something like: https://yoursite.com/login
  - This is not required, but without it we don't know where to send a user if they bookmarked our page or followed a link to the login that did not come from your login redirect.
- logout (route location on your website where we will redirect users to AFTER they have logged out and we have removed their session)


## Step 2

Update the URL values in the [Vault Vision Management Panel](https://manage.vaultvision.com/go#applications) for your application.


