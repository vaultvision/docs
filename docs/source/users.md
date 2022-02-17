Users
========

## Properties

**Name** - This name that will refer to the user in this tenant.  It does not have to be unique and will be used for system and email messages to the User.

**Email** - This is the email address for the user, and must be unique inside each tenant.  There can not be two users in the same tenant using the same email, it is akin to a username, and is the unique identifier for a user account.

**Password** - This is the password credential users provide to authenticate themselves.  Setting this Password field for a user that currently has a FIDO security key credential assigned as the account credential, will cause that FIDO security key credential to be removed from the user account and it will be replaced by the password set in this field.

## Actions

**Update** - The user's name can be updated

**Block/Unblock** - Blocking a use will cause them to be blocked from authenticating, meaning they won't be able to login anymore.  This can be undone by Unblocking the user.

**Delete** - This will remove the user from the tentant, they will no longer be able to login and if they re-register, they will have a different id and user account.