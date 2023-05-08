Tenants - [Vault Vision](https://vaultvision.com) 
========

Tenants are the center hub of [Vault Vision's](https://vaultvision.com) user authentication platform. It is the core entity that holds all your users, application links, and unique branding and authentication settings.

## Properties

**Domain** - This is the domain for your auth platform, this is where your signup and login pages will live. This is what will show in the users address bar when signing up or logging in to your services.  Once set, this can not be changed without contacting support.  This is because your users are familiar with where they signed up, and any changes need to be communicated and coordinated with them so that they understand where and how they are authenticating for your service.

```{note} Custom Domains
If you choose a custom domain for your tenant, something like auth.mycompany.com, then you will need to make sure you create a DNS CNAME record for that custom domain (auth.mycompany.com in this example) to point to nextgenauth.vaultvision.com

This is how you will connect your custom domain to our services
```

**Company Name** - This is usually just your company name. It is the name that you can use to identify yourself to end users.  We will default to this name when sending system messages and emails.

**Support Email** - This is the email address we will show to your end users so they can reach out for support if needed.  Usually displayed in either system messages or if an error condition arises.

**Support URL** - This is the website URL we will show to your end users so they can reach out for support if needed.  Usually displayed in either system messages or if an error condition arises.  Additionally, this is where we will send end users that need more help during signup or login.

**Terms of Service URL** - This is the link to your terms of service for your web application.  We show this link on your signup page and require that your end users agree to it during signup.

**Terms of Service Version** - This is the version of your terms of service that we record when a users signs up for your service.  At signup, after they agree to the terms of service, we will record which version of the terms they agreed to based on what is currently set in this field for your tenant.  When you update your terms of service you should update this version number as well so that we will maintain accurate records of what version users agreed to when they signed up.

**Privacy Policy URL** - This is the link to your privacy policy for your company.  We show this link on your signup page and require that your end users agree to it during signup.

**Privacy Policy Version** - This is the version of your privacy policy that we record when a users signs up for your service.  At signup, after they agree to the privacy policy, we will record which version of the policy they agreed to based on what is currently set in this field for your tenant.  When you update your privacy policy you should update this version number as well so that we will maintain accurate records of what version users agreed to when they signed up.

**Email Verification Delay (seconds)** - If you have email verification disabled for users, you can use this setting to add a verification delay.  This delay happens after a user signs up.  This delay is useful for reducing the initial friction when a user signs-ups.  By disabling email verification AND setting this delay value, your new user sign-ups won't be required to verify their email until then next time they login after the delay duration has passed.  A typical use case is to set this to 60 seconds so that the first time a user signs-up, they won't be blocked with a requirement to verify their email, yet on any logins that happen after 60 seconds later will block the user from completing sign-in until they have verified their email by entering the code sent to them.  Setting this value to 0 will completely remove all email verification requirements.  If you never want to verify your user's email, set this to 0.

**Login Session Persistence Lifetime (seconds)** - This is the duration of the users login session.  This controls the lifetime and expiration time of the login cookie.  While this lifetime is active and the user's browser has an un-expired login cookie, the user will be authenticated and will not be prompted to login, they will redirected back to the application with the new valid login tokens.  When this lifetime expires, any new authentication requests will prompt the user to login again.  Setting this value will make the browser remember the users login session even if they close and re-open the browser.  Setting this to 0 will make the users login session not be remembered after they close the browser.  Setting this to 0 will make the login cookie a session cookie that will disappear when the browser is closed.  Login sessions are always destroyed on logout.

**MFA/TOTP Session Persistence Lifetime (seconds)** - This is the duration of the user's MFA/TOTP remembered session. When a users enters their TOTP code in their MFA login flow, if they choose to 'Remember Me', their 2nd factor will be remembered on their device for this duration.  This means that the next time the users authenticates, if the MFA/TOTP is still active, they will not be prompted for their MFA/TOTP code again.  A typical use case for this setting is to combine it with a shorter 'Login Session Persistence Lifetime' so you get the benefit of frequent re-authentications, yet only prompt for the MFA/TOTP on a new device or after a very long time.  Typical values would be 30 days for an 'MFA/TOTP Session Persistence Lifetime' and only 24 hours for 'Login Session Persistence Lifetime (seconds)'.  This way users authenticate each day, but only have to enter their MFA/TOTP code once a month. MFA/TOTP sessions are always destroyed on logout.

**Allow Password Logins** - This is setting determines whether users will be able to authenticate using a password. Disabling this will mean users can no longer use a password to login, they will need to use either social logins, or passkey/security keys.

**Allow Social Logins** - This is setting determines whether users will be able to authenticate using social logins like Google, Apple, Microsoft. Disabling this will mean users can no longer use a social login, they will need to use either password, or passkey/security keys.

**Allow Security Key Logins** - This is setting determines whether users will be able to authenticate using WebAuthn/FIDO authenticators, including passkey. Disabling this will mean users can no longer use passkey or security keys to login, they will need to use either password, or social logins.

**Allow TOTP Authenticator Apps** - This is setting determines whether users are able to add a TOTP authenticator app as a 2nd factor to their password.  Disabling this will block users from adding a TOTP authenticator app, and could break logins for users that had already added one to their account.

**Allow TOTP via Email Code** - This is setting determines whether users are able to use email to get a TOTP code as a 2nd factor to their password.  Disabling this will block users from using their email as a method to receive a TOTP code.

**Disable Email Verification for Users** - This is setting determines whether users are required to verify their email address after signing up and logging in. If you 'Disable Email Verification', users will be able to signup and login without being blocked to enter a code that is sent to their email address.  This verification can also be delayed by setting a delay in the 'Email Verification Delay' setting.  If you never want to a user to be required to verify their email, check this 'Disable Email Verification' setting and set 'Email Verification Delay' to 0.

**Require Multi-Factor Authentication (MFA)** - This is setting determines whether users are required to use MFA/TOTP codes with their passwords. When required, users on signup and login will be required to enter a TOTP code either from a TOTP authenticator app (if allowed by the setting above) or from a email (if allowed by the setting above) sent to their email address.  This setting only requires a TOTP code for password logins.  This setting has no impact on social and passkey/security keys, those login types do not use TOTP MFA (this will be an option soon though.)

**Developer Mode** - This is setting determines whether helpful debug messages are shown on your auth tenant.  Enabling this will give helpful tips on setting the proper callback urls for your application and solving other mis-configurations.  Typically, you will only want to enable this during setup or troubleshooting, as it will show debug messages that will only make sense to you and not to your users.

**Allow Public Signups** - This is setting determines whether users can register themselves.  When enabled, users will be able to create their own accounts using the registration signup page.  When disabled, the registration signup page does not exist, and only tenant admins will be able to create new user accounts.  This is typically used for systems that are internal to a company or is for employee's only and NOT for the general public.

**Require New Users to be Approved by Admin** - This is setting determines whether new users are automatically disabled/blocked on creation. This is useful if you want users to self-register but not gain access until they are approved by the tenant admin. 


**Logo** - This is the image that will be displayed on your signup and login pages.  It will also be used in emails and system messages.

## Actions

None currently
