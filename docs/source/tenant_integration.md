Tenant Integration - [Vault Vision](https://vaultvision.com) 
==================

## Prerequisites

Some kind of web server with the following:
	- outbound network access to nextgenauth.vaultvision.com over port 443
	- ability to have and handle 2 incoming routes open to the internet over port 443
	- ability to perform 302 redirects
	- ability to set and store 4 server-side variables (client_id, client_secret, base_url, your_callback_url). Most of the time these are stored as an environment or configuration variable.
	- (optional) ability to maintain a session, this needed assuming you want users to only authenticate once and be in some kind of logged in state. This could be a cookie, session server, or session specific cache.
	- (optional in the case of using a custom domain) ability to set a DNS CNAME for your custom domain that points to nextgenauth.vaultvision.com

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


