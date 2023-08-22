# API Reference - [Vault Vision](https://vaultvision.com) 


## Overview

[Vault Vision](https://vaultvision.com) provides all customers access to
a [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) based
API. A quick summary:

 - Request bodies are [JSON-encoded](https://www.json.org/json-en.html)
 - Responses are also [JSON-encoded](https://www.json.org/json-en.html)
 - Uses standard HTTP response codes (200, 400, ...)
 - Uses standard HTTP verbs (GET, POST, ...)
 - Authentication via [API Keys](apikeys.md) (Authorization: Bearer $VV_API_KEY)
 - The production endpoint is: `https://api.vaultvision.com`


Our goal is to provide comprehensive documentation. We will gladly accept pull requests at [github.com/vaultvision/docs](https://github.com/vaultvision/docs) or feel free to [contact us](https://vaultvision.com/contact-us/) directly with feedback / questions.


### Authentication

All requests to the API must be authenticated with a **secret** [API Key](apikeys.md). You may create and manage your API Keys in the [management console](https://manage.vaultvision.com/apikeys), see our [API Key creation guide](apikeys.md) here.


Secret API Keys have a prefix of `"vv_"` so they may be identified easily. Beyond that all characters are random, some examples:

 - `vv_oFVTAiPkICpOewyuV2mINX1rSFxzdIkR`
 - `vv_uAmkBd4nRsjFPBfsJFrmvNmKOMARrapZ`

```{note}
Your __secret__ API Keys must be kept secure, do not share your secret API keys in publicly accessible areas.
```

Secret keys are provided in the HTTP Authorization header as a bearer token. For example:

``` shell
curl \
  https://api.vaultvision.com/v1/tenants \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer vv_oFVTAiPkICpOewyuV2mINX1rSFxzdIkR"
```


### Metadata

Most updatable API objects have a metadata field you may use for storing arbitrary key-value data. You can use this field for storing additional information directly on an object. For example you could store your systems own unique ID's for a given user on the `User` object to lookup after they login.

You can specify up to 20 keys, with key names up to 100 characters long and values up to 1000 characters long. Your users won't see metadata unless you show it to them.

```{note}
Don't store any sensitive information in metadata.
```


### Errors

Vault Vision uses conventional HTTP response status codes to indicate the success or failure of an API request:

  - 2xx range indicate success.
  - 4xx range indicate an error with the request.
  - 5xx range indicate an error with the tenants configuration or in rare circumstances our infrastructure.

When a failure occurs we always return JSON objects containing additional information about errors. These errors include a string "code" and a "uuid" you can supply our support with so we can lookup additional details about your request. An example error for authentication failure:

``` json
{
  "type": "Error",
  "uuid": "a31680a3-663e-4693-9152-e2cc9a093811",
  "code": "authentication_failure",
  "status_code": 401
}
```


### Update/Create Conventions

For updates and creates, we only support full object POST requests, meaning the entire object with all of it's fields and properties needs to be included in the request. To update a single field you should first fetch the latest version of the object, modify it and post it back with all of it's fields even if the fields are not changing. We ignore some system managed fields like the id, created_at and updated_at fields. See each Object for more information about mutability.

It's also worth noting that many fields are omitted when they are the zero-value or false for that type. For example when a bool is false we often will omit that key from the response. This may change in a future release to give more consistent experience across integrations.  Omitted values should be assumed to be zero-value or false.


## Paths

The full list of request paths and API endpoints are organized below. The route parameters (`tenant_id`, `user_id`, etc...) are always required, the ID in the request body/payload is ignored. ONLY the id that ID part of the URL as a route parameter is used.  Request paths which end with a single specific ID will return a single object, other requests paths that end without a single specific ID will return a list of objects.

Tenants:

 - [GET /v1/tenants](#get-v1-tenants)
 - [GET /v1/tenants/:tenant_id](#get-v1-tenants-tenant-id)
 - [POST /v1/tenants/:tenant_id](#post-v1-tenants-tenant-id)

Applications:

 - [GET /v1/tenants/:tenant_id/applications](#get-v1-tenants-tenant-id-applications)
 - [POST /v1/tenants/:tenant_id/applications](#post-v1-tenants-tenant-id-applications)
 - [GET /v1/tenants/:tenant_id/applications/:application_id](#get-v1-tenants-tenant-id-applications-application-id)
 - [POST /v1/tenants/:tenant_id/applications/:application_id](#post-v1-tenants-tenant-id-applications-application-id)
 - [DELETE /v1/tenants/:tenant_id/applications/:application_id](#delete-v1-tenants-tenant-id-applications-application-id)

Users:

 - [GET /v1/tenants/:tenant_id/users](#get-v1-tenants-tenant-id-users)
 - [POST /v1/tenants/:tenant_id/users](#post-v1-tenants-tenant-id-users)
 - [GET /v1/tenants/:tenant_id/users/:user_id](#get-v1-tenants-tenant-id-users-user-id)
 - [POST /v1/tenants/:tenant_id/users/:user_id](#post-v1-tenants-tenant-id-users-user-id)
 - [DELETE /v1/tenants/:tenant_id/users/:user_id](#delete-v1-tenants-tenant-id-users-user-id)

User Credentials:

 - [GET /v1/tenants/:tenant_id/users/:user_id/credentials](#get-v1-tenants-tenant-id-users-user-id-credentials)
 - [POST /v1/tenants/:tenant_id/users/:user_id/credentials](#post-v1-tenants-tenant-id-users-user-id-credentials)
 - [GET /v1/tenants/:tenant_id/users/:user_id/credentials/:credential_id](#get-v1-tenants-tenant-id-users-user-id-credentials-credential-id)
 - [DELETE /v1/tenants/:tenant_id/users/:user_id/credentials/:credential_id](#delete-v1-tenants-tenant-id-users-user-id-credentials-credential-id)


### GET /v1/tenants

Returns the list of tenants the current API Key has access to.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "List",
  "total": 2,
  "count": 2,
  "limit": 100,
  "data": [
    {
      "type": "Tenant",
      "id": "i1JfrfWIwQiQ",
      "created_at": "2023-08-18T21:41:13.850608202Z",
      "updated_at": "2023-08-18T21:41:13.850608202Z",
      "settings": {
        "domain": "dev-xbwlrp.vvkey.test",
        "company_name": "Development Environment",
        "logo_image_text": "dev-xbwlrp",
        "allow_social": true,
        "allow_hardware": true,
        "allow_passwords": true,
        "allow_totp_app": true,
        "allow_totp_email": true,
        "allow_unverified": true,
        "remember_device": true,
        "remember_device_seconds": 2592000,
        "remember_login_seconds": 2592000,
        "allow_signups": true,
        "developer_mode": true
      }
    },
    {
      "type": "Tenant",
      "id": "local-acme01",
      "name": "acme01",
      "created_at": "2023-08-18T15:11:28.708085985Z",
      "updated_at": "2023-08-18T15:11:28.708085985Z",
      "settings": {
        "domain": "acme01.vvkey.test",
        "company_name": "acme01",
        "support_email": "support@acme01.test",
        "allow_social": true,
        "allow_hardware": true,
        "allow_passwords": true,
        "allow_totp_app": true,
        "allow_totp_email": true,
        "allow_unverified": true,
        "remember_device": true,
        "remember_device_seconds": 2592000,
        "remember_login_seconds": 2592000,
        "allow_signups": true
      }
    }
  ]
}
```


### GET /v1/tenants/:tenant_id

Get a specific tenant by ID.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "Tenant",
  "id": "local-acme01",
  "name": "acme01",
  "created_at": "2023-08-18T15:11:28.708085985Z",
  "updated_at": "2023-08-18T15:11:28.708085985Z",
  "settings": {
    "domain": "acme01.vvkey.test",
    "company_name": "acme01",
    "support_email": "support@acme01.test",
    "allow_social": true,
    "allow_hardware": true,
    "allow_passwords": true,
    "allow_totp_app": true,
    "allow_totp_email": true,
    "allow_unverified": true,
    "remember_device": true,
    "remember_device_seconds": 2592000,
    "remember_login_seconds": 2592000,
    "allow_signups": true
  }
}
```


### POST /v1/tenants/:tenant_id

Update the tenant specified by tenant_id.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"metadata": {"mykey1":"myval1"}}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "Tenant",
  "id": "local-acme01",
  "name": "acme01",
  "created_at": "2023-08-18T15:11:28.708085985Z",
  "updated_at": "2023-08-18T15:11:28.708085985Z",
  "metadata": {
    "mykey1": "myval1"
  },
  "settings": {
    "domain": "acme01.vvkey.test",
    "company_name": "acme01",
    "support_email": "support@acme01.test",
    "allow_social": true,
    "allow_hardware": true,
    "allow_passwords": true,
    "allow_totp_app": true,
    "allow_totp_email": true,
    "allow_unverified": true,
    "remember_device": true,
    "remember_device_seconds": 2592000,
    "remember_login_seconds": 2592000,
    "allow_signups": true
  }
}
```


### POST /v1/tenants/:tenant_id/applications

Create a new application. An application is your OIDC client used to initiate and handle authentication callbacks.

Request:
``` shell
echo '{
  "type": "Application",
  "name": "MyNewApp",
  "login_url": "https://example.test/auth/login",
  "logout_urls": [
    "https://example.test/auth/logout"
  ],
  "redirect_urls": [
    "https://example.test/auth/callback"
  ]
}' | curl \
       https://api.vaultvision.com/v1/tenants/local-acme01/applications \
         -X POST \
         -H "accept: application/json" \
         -H "authorization: Bearer $VV_API_KEY" \
         -d@-
```

Response:
``` json
{
  "type": "Application",
  "id": "37SenPbBds9q",
  "name": "MyNewApp",
  "created_at": "2023-08-18T23:08:56.256482702Z",
  "updated_at": "2023-08-18T23:08:56.256482702Z",
  "login_url": "https://example.test/auth/login",
  "logout_urls": [
    "https://example.test/auth/logout"
  ],
  "redirect_urls": [
    "https://example.test/auth/callback"
  ]
}
```


### GET /v1/tenants/:tenant_id/applications

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/applications \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "List",
  "total": 4,
  "count": 4,
  "limit": 100,
  "data": [
    {
      "type": "Application",
      "id": "J3Or5KNHIUDl",
      "name": "MyNewApp",
      "created_at": "2023-08-18T23:14:03.782059707Z",
      "updated_at": "2023-08-18T23:14:03.782059707Z",
      "secret": "4fZyeKjrJaBbFVeLzQy2TCsJ",
      "login_url": "https://example.test/auth/login",
      "logout_urls": [
        "https://example.test/auth/logout"
      ],
      "redirect_urls": [
        "https://example.test/auth/callback"
      ]
    }
  ]
}
```


### GET /v1/tenants/:tenant_id/applications/:application_id

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/applications/J3Or5KNHIUDl \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
```json
{
  "type": "Application",
  "id": "J3Or5KNHIUDl",
  "name": "MyNewApp",
  "created_at": "2023-08-18T23:14:03.782059707Z",
  "updated_at": "2023-08-18T23:14:03.782059707Z",
  "secret": "4fZyeKjrJaBbFVeLzQy2TCsJ",
  "login_url": "https://example.test/auth/login",
  "logout_urls": [
    "https://example.test/auth/logout"
  ],
  "redirect_urls": [
    "https://example.test/auth/callback"
  ]
}
```

### POST /v1/tenants/:tenant_id/applications/:application_id

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/applications/J3Or5KNHIUDl \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"metadata": {"mykey1":"myval1"}}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01/applications/J3Or5KNHIUDl \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "Application",
  "id": "J3Or5KNHIUDl",
  "name": "MyNewApp",
  "created_at": "2023-08-18T23:14:03.782059707Z",
  "updated_at": "2023-08-18T23:15:41.060329051Z",
  "metadata": {
    "mykey1": "myval1"
  },
  "secret": "4fZyeKjrJaBbFVeLzQy2TCsJ",
  "login_url": "https://example.test/auth/login",
  "logout_urls": [
    "https://example.test/auth/logout"
  ],
  "redirect_urls": [
    "https://example.test/auth/callback"
  ]
}
```


### DELETE /v1/tenants/:tenant_id/applications/:application_id

Delete returns the latest version of the deleted object before permanently removing it from the system, all future GET requests are guaranteed to no longer return the object.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/applications/37SenPbBds9q \
  -X DELETE \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "Application",
  "id": "37SenPbBds9q",
  "name": "MyNewApp",
  "created_at": "2023-08-18T23:08:56.256482702Z",
  "updated_at": "2023-08-18T23:08:56.256482702Z",
  "login_url": "https://example.test/auth/login",
  "logout_urls": [
    "https://example.test/auth/logout"
  ],
  "redirect_urls": [
    "https://example.test/auth/callback"
  ]
}
```


### POST /v1/tenants/:tenant_id/users

Create a new user with no credentials, they will need to reset their password to login.

Request:
``` shell
echo '{
  "metadata": { "other_id": "other_id_01" },
  "profile": {
    "email": "test01@example.test",
    "name": "Test User01",
    "given_namename": "Test",
    "family_name": "User01"
  }
}' | curl \
       https://api.vaultvision.com/v1/tenants/local-acme01/users \
         -X POST \
         -H "accept: application/json" \
         -H "authorization: Bearer $VV_API_KEY" \
         -d@-
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:04:24.344871427Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test"
  }
}
```


### GET /v1/tenants/:tenant_id/users

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "List",
  "total": 1,
  "count": 1,
  "limit": 100,
  "data": [
    {
      "type": "User",
      "id": "9cb0Q44OoPO4",
      "created_at": "2023-08-21T15:04:24.344871427Z",
      "updated_at": "2023-08-21T15:06:43.49365588Z",
      "metadata": {
        "other_id": "other_id_01"
      },
      "profile": {
        "name": "Test User01",
        "family_name": "User01",
        "email": "test01@example.test"
      }
    }
  ]
}
```


### GET /v1/tenants/:tenant_id/users/:user_id

Get a user.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:13:47.787592127Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test"
  }
}
```


### POST /v1/tenants/:tenant_id/users/:user_id

Update a user.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"metadata": {"other_id":"other_id_01"}}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:13:47.787592127Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "verified_at": "2023-08-21T15:06:43.49365588Z",
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test",
    "email_verified": true
  }
}
```


### DELETE /v1/tenants/:tenant_id/users/:user_id

Delete returns the latest version of the deleted object before permanently removing it from the system, all future GET requests are guaranteed to no longer return the object.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
  -X DELETE \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:13:47.787592127Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test"
  }
}
```


### GET /v1/tenants/:tenant_id/users/:user_id/credentials

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4/credentials \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "List",
  "total": 1,
  "count": 1,
  "limit": 100,
  "data": [
    {
      "type": "PasswordCredential",
      "id": "password",
      "created_at": "2023-08-21T16:30:26.641417117Z",
      "updated_at": "2023-08-21T16:30:35.576230491Z",
      "password": {
        "alg": "bcrypt",
        "cost": 10,
        "hash": "JDJhJDEwJFA1NFEzSzIxYlZtUjFVcVYwbm1VSS5KYnV0cUVJMzVnQ29kUjRyQlRtdUtyN0JVVklCUkZL"
      }
    }
  ]
}
```


### GET /v1/tenants/:tenant_id/users/:user_id/credentials/:credential_id

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4/credentials/password \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "PasswordCredential",
  "id": "password",
  "created_at": "2023-08-21T15:56:09.394956823Z",
  "updated_at": "2023-08-21T15:56:09.394956823Z",
  "password": {
    "alg": "bcrypt",
    "cost": 10,
    "hash": "JDJhJDEwJFh5TUhvQUlUZi9qek5nNEszSmIvYy5BZGlDV3U0dVouc0pYZVZIVGhwY3JBaXJidHdiZnIu"
  }
}
```


### POST /v1/tenants/:tenant_id/users/:user_id/credentials/:credential_id

Update a users credential. All credential types may be disabled/enabled and have the metadata updated, but only passowrds allow other fields to be modified.

Below is an example of how to disable the users password.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4/credentials/password \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"disabled": true}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4/credentials/password \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "PasswordCredential",
  "id": "password",
  "created_at": "2023-08-21T15:56:09.394956823Z",
  "updated_at": "2023-08-21T15:56:33.56633403Z",
  "disabled": true,
  "password": {
    "alg": "bcrypt",
    "cost": 10,
    "hash": "JDJhJDEwJFh5TUhvQUlUZi9qek5nNEszSmIvYy5BZGlDV3U0dVouc0pYZVZIVGhwY3JBaXJidHdiZnIu"
  }
}
```


### DELETE /v1/tenants/:tenant_id/users/:user_id/credentials/:credential_id

Delete will remove the credential for the given user, if it is their last remaining credential they will no longer be able to login.

```{note}
The user can still perform a password reset to gain access to their account, set the user to "disabled" if you want to block future logins. See [Example - Disable a user](api.md#example-disable-a-user).
```

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4/credentials/password \
  -X DELETE \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Response:
``` json
{
  "type": "PasswordCredential",
  "id": "password",
  "created_at": "2023-08-21T15:56:09.394956823Z",
  "updated_at": "2023-08-21T15:56:33.56633403Z",
  "disabled": true,
  "password": {
    "alg": "bcrypt",
    "cost": 10,
    "hash": "JDJhJDEwJFh5TUhvQUlUZi9qek5nNEszSmIvYy5BZGlDV3U0dVouc0pYZVZIVGhwY3JBaXJidHdiZnIu"
  }
}
```


## Examples

Below are some simple runnable examples using curl along side [jq](https://jqlang.github.io/jq/).

jq is a command-line JSON processor that we will use in these examples as an easy way to take the JSON outputs from API calls make a minor modification and then pass that modified JSON as input into the next API call.  Because udpates to objects require ALL the fields of an object, even the fields that aren't changing, you will see the jq library used in this specific pattern is used to make updating a single field as easy possible.  Simply put, in order to make updates, you need to first do a GET of an object to fetch all its fields, then modify the fields you wish to change and POST the entire modified object back to the API.  The jq library is an easy way to do this JSON modification on the command-line.  If you are using a language like javascript or python, you can perform this pattern without the use of jq.  jq is used in these examples because they are command-line examples.


```{note}
All the example data here was randomly generated for this documentation. Everything from the application secrets to the object ID's have never actually existed. You must replace them with your own data for the requests to work.
```

### Example - Changing a Tenant Setting (JQ)

Here's a simple one liner to change the "allow_unverified" field to false using jq and curl. This works by sending a GET to fetch the tenant object, editing the response inline, and posting it directly back to the API.

``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '.settings.allow_unverified = false' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

```{note}
When allow_unverified is false users that haven't verified their email address are redirected to the email verification workflow, which must be completed before they are able to login.
```


### Example - Changing a Tenant Setting (Manual)

Here's a step by step example of how to change the "allow_unverified" field to false.

First lets get the latest version of our tenant:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY"
```

Our result:
``` json
{
  "type": "Tenant",
  "id": "local-acme01",
  "name": "acme01",
  "created_at": "2023-08-18T15:11:28.708085985Z",
  "updated_at": "2023-08-18T21:58:05.547823288Z",
  "settings": {
    "domain": "acme01.vvkey.test",
    "company_name": "acme01",
    "support_email": "support@acme01.test",
    "allow_social": true,
    "allow_hardware": true,
    "allow_passwords": true,
    "allow_totp_app": true,
    "allow_totp_email": true,
    "allow_unverified": true,
    "remember_device": true,
    "remember_device_seconds": 2592000,
    "remember_login_seconds": 2592000,
    "allow_signups": true
  }
}
```

Now put these settings in a file and edit them by hand. One option is we can use bash to quickly create a `tenant-update.json` file.
``` shell
echo '{
  "type": "Tenant",
  "id": "local-acme01",
  "name": "acme01",
  "created_at": "2023-08-18T15:11:28.708085985Z",
  "updated_at": "2023-08-18T21:58:05.547823288Z",
  "settings": {
    "domain": "acme01.vvkey.test",
    "company_name": "acme01",
    "support_email": "support@acme01.test",
    "allow_social": true,
    "allow_hardware": true,
    "allow_passwords": true,
    "allow_totp_app": true,
    "allow_totp_email": true,
    "allow_unverified": false,
    "remember_device": true,
    "remember_device_seconds": 2592000,
    "remember_login_seconds": 2592000,
    "allow_signups": true
  }
}' > tenant-update.json
```

Send the updated settings to the API:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X POST \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
  -d@tenant-update.json
```

The response should show allow_unverified setting is now set to false as well as the updated_at field will reflect the time of the change.
``` json
{
  "type": "Tenant",
  "id": "local-acme01",
  "name": "acme01",
  "created_at": "2023-08-18T15:11:28.708085985Z",
  "updated_at": "2023-08-18T21:58:15.547823288Z",
  "settings": {
    "domain": "acme01.vvkey.test",
    "company_name": "acme01",
    "support_email": "support@acme01.test",
    "allow_social": true,
    "allow_hardware": true,
    "allow_passwords": true,
    "allow_totp_app": true,
    "allow_totp_email": true,
    "allow_unverified": false,
    "remember_device": true,
    "remember_device_seconds": 2592000,
    "remember_login_seconds": 2592000,
    "allow_signups": true
  }
}
```


### Example - Metadata

Here's an example of how to add metadata using curl:

``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"metadata": {"mykey1":"myval1"}}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```


### Example - Disable a user

Disabling a user blocks them from logging in.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"disabled": true}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:38:10.606366075Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "disabled": true,
  "verified_at": "2023-08-21T15:06:43.49365588Z",
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test",
    "email_verified": true
  }
}
```

### Example - Enable a user

Enable a user that was previously disabled.

Request:
``` shell
curl \
  https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
  -X GET \
  -H "accept: application/json" \
  -H "authorization: Bearer $VV_API_KEY" \
    | jq -r '. += {"disabled": false}' \
    | curl \
        https://api.vaultvision.com/v1/tenants/local-acme01/users/9cb0Q44OoPO4 \
          -X POST \
          -H "accept: application/json" \
          -H "authorization: Bearer $VV_API_KEY" \
          -d@-
```

Response:
``` json
{
  "type": "User",
  "id": "9cb0Q44OoPO4",
  "created_at": "2023-08-21T15:04:24.344871427Z",
  "updated_at": "2023-08-21T15:38:53.495536342Z",
  "metadata": {
    "other_id": "other_id_01"
  },
  "verified_at": "2023-08-21T15:06:43.49365588Z",
  "profile": {
    "name": "Test User01",
    "family_name": "User01",
    "email": "test01@example.test",
    "email_verified": true
  }
}
```
