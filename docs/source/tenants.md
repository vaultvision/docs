Tenants - Vault Vision
========

Tenants are the center hub of [Vault Vision's](https://vaultvision.com) user authentication platform. It is the core entity that holds all your users, application links, and unique branding and authentication settings.

## Properties

**Domain** - This is the domain for your auth platform, this is where your signup and login pages will live. This is what will show in the users address bar when signing up or logging in to your services.  Once set, this can not be changed without contacting support.  This is because your users are familiar with where they signed up, and any changes need to be communicated and coordinated with them so that they understand where and how they are authenticating for your service.

```{note} Custom Domains
If you choose a custom domain for your tenant, something like auth.mycompany.com, then you will need to make sure you create a DNS CNAME record for that custom domain (auth.mycompany.com in this example) to point to nextgenauth.vaultvision.com

This is how you will connect your custom domain to our services
```

**Display Name** - This is usually just your company name. It is the name that you can use to indentify yourself to end users.  We will default to this name when sending system messages.

**Support Email** - This is the email address we will show to your end users so they can reach out for support if needed.  Usually displayed in either system messages or if an error condition arises.

**Support URL** - This is the website URL we will show to your end users so they can reach out for support if needed.  Usually displayed in either system messages or if an error condition arises.  Additionally, this is where we will send end users that need more help during signup or login.

**Terms of Service URL** - This is the link to your terms of service for your web application.  We show this link on your signup page and require that your end users agree to it during signup.

**Terms of Service Version** - This is the version of your terms of service that we record when a users signs up for your service.  At signup, after they agree to the terms of service, we will record which version of the terms they agreed to based on what is currently set in this field for your tenant.  When you update your terms of service you should update this version number as well so that we will maintain accurate records of what version users agreed to when they signed up.

**Privacy Policy URL** - This is the link to your privacy policy for your company.  We show this link on your signup page and require that your end users agree to it during signup.

**Privacy Policy Version** - This is the version of your privacy policy that we record when a users signs up for your service.  At signup, after they agree to the privacy policy, we will record which version of the policy they agreed to based on what is currently set in this field for your tenant.  When you update your privacy policy you should update this version number as well so that we will maintain accurate records of what version users agreed to when they signed up.

**Logo** - This is the image that will be displayed on your sigunp and login pages.  It will also be used in emails and system messages.

## Actions

None currently, Once
