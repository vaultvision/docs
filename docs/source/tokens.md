ID Tokens, Access Tokens, UserInfo - [Vault Vision](https://vaultvision.com) 
==================

## ID Tokens 

An ID token is the result of a successful authenication sequence, it represents the assertion that the user represented by the identity enclosed inside the ID token has successful authenticated with a proper and valid credential.  During an OAuth flow, the OAuth client application will receive this ID token as part of a payload in a callback that occurs after the user has been authenticated. Usually, the client application will then validate and decode this ID token and use the information contained in the token to establish a new user session in the client application for this newly validated and authenticated user.  ID tokens are designed to be short lived and should NOT be re-used as a session token.  Best practice is to create a new session JWT that you store in an HTTPOnly, SameSite, secure cookie (not in local storage, not in an unsecure cookie, and not in a javascript readable cookie; these locations are insecure and can be used it XSS attacks to steal a user's session).

Formal definition from [Open ID - ID token](https://openid.net/specs/openid-connect-core-1_0.html#IDToken)
> The primary extension that OpenID Connect makes to OAuth 2.0 to enable End-Users to be Authenticated is the ID Token data structure. The ID Token is a security token that contains Claims about the Authentication of an End-User by an Authorization Server when using a Client, and potentially other requested Claims. The ID Token is represented as a [JSON Web Token (JWT)](https://openid.net/specs/openid-connect-core-1_0.html#JWT) [JWT].

```{note}
Great tool for decoding and inspecting signed JWTs
- [JWT Decoder, Verifier, Generator, Decryptor](https://dinochiesa.github.io/jwt/)
```
### ID Token Example
See the below for the contents of the payload of an actual decoded JWT ID token issued by the Vault Vision authentication flow:
```js
{
  iss: 'https://auth.vaultvision.com',
  sub: 'osjm55CZtYkr',
  aud: [ 'client-id' ],
  exp: 1684517823,
  iat: 1684514223,
  auth_time: 1684513456,
  nonce: 'NQjSh-MmMHi0kqyK9ZV6TA8o73jsKMvt2c-caMx2c1Q'
}
```

This token asserts that the user (sub) with id of 'osjm55CZtYkr' successfully authenicated at: 1684513456 (Friday, May 19, 2023 4:24:16 PM)

Notice that the 'exp' (expire time) and 'iat' (issued at time) are 3600 apart, this is because the id tokens issued by Vault Vision are valid for 1 hour.  NOTE: this expire time is just a sanity lifetime for the JWT itself and has nothing to do with the duration of the a user's login session.  It is just a simple expiry value to limit the time a token is considered valid.  Even though a token is valid for 1 hour, actual user sessions lifetimes are configurable and can be configured for as little as 1 second or until the browser closes.  Do not use this ID token 'exp' time as a user session expiration time.

```{note}
Great tool for decoding and inspecting signed JWTs
- [JWT Decoder, Verifier, Generator, Decryptor](https://dinochiesa.github.io/jwt/)
```

- iss  
  -  REQUIRED. Issuer Identifier for the Issuer of the response. The iss value is a case sensitive URL using the https scheme that contains scheme, host, and optionally, port number and path components and no query or fragment components.

- sub  
  -  REQUIRED. Subject Identifier. A locally unique and never reassigned identifier within the Issuer for the End-User, which is intended to be consumed by the Client, e.g., 24400320 or AItOawmwtWwcT0k51BayewNvutrJUqsvl6qs7A4. It MUST NOT exceed 255 ASCII characters in length. The sub value is a case sensitive string.

- aud 
  -  REQUIRED. Audience(s) that this ID Token is intended for. It MUST contain the OAuth 2.0 client_id of the Relying Party as an audience value. It MAY also contain identifiers for other audiences. In the general case, the aud value is an array of case sensitive strings. In the common special case when there is one audience, the aud value MAY be a single case sensitive string.

- exp
  -  REQUIRED. Expiration time on or after which the ID Token MUST NOT be accepted for processing. The processing of this parameter requires that the current date/time MUST be before the expiration date/time listed in the value. Implementers MAY provide for some small leeway, usually no more than a few minutes, to account for clock skew. Its value is a JSON number representing the number of seconds from 1970-01-01T0:0:0Z as measured in UTC until the date/time. See [RFC3339](https://www.rfc-editor.org/rfc/rfc3339) for details regarding date/times in general and UTC in particular.

- iat
  -  REQUIRED. Time at which the JWT was issued. Its value is a JSON number representing the number of seconds from 1970-01-01T0:0:0Z as measured in UTC until the date/time.

- auth_time
  -  Time when the End-User authentication occurred. Its value is a JSON number representing the number of seconds from 1970-01-01T0:0:0Z as measured in UTC until the date/time. When a max_age request is made or when auth_time is requested as an Essential Claim, then this Claim is REQUIRED; otherwise, its inclusion is OPTIONAL. (The auth_time Claim semantically corresponds to the OpenID 2.0 PAPE [OpenID.PAPE] auth_time response parameter.)

- nonce
  -  String value used to associate a Client session with an ID Token, and to mitigate replay attacks. The value is passed through unmodified from the Authentication Request to the ID Token. If present in the ID Token, Clients MUST verify that the nonce Claim Value is equal to the value of the nonce parameter sent in the Authentication Request. If present in the Authentication Request, Authorization Servers MUST include a nonce Claim in the ID Token with the Claim Value being the nonce value sent in the Authentication Request. Authorization Servers SHOULD perform no other processing on nonce values used. The nonce value is a case sensitive string.

## Access Tokens 

Access tokens are the tokens used to make authenticated requests to resource API endpoints.  Resource servers use these access tokens to validate that the requested is 

Formal definition from [RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749#section-1.4)
>  Access tokens are credentials used to access protected resources.  An access token is a string representing an authorization issued to the client.  The string is usually opaque to the client.  Tokens represent specific scopes and durations of access, granted by the resource owner, and enforced by the resource server and authorization server.

There are 3 specific points regarding access tokens that are key to the security model of OAuth:

- Access tokens must not be read or interpreted by the OAuth client. The OAuth client is not the intended audience of the token, the resource server is the intended audience for the access token.
- Access tokens do not convey user identity or any other information about the user to the OAuth client, ID tokens are used for that puprose.
- Access tokens should only be used to make requests to the resource server. Additionally, ID tokens must not be used to make requests to the resource server.

In a typical authentication flow, both an access token and an ID token are returned to the OAuth client in the auth callback as part of a token set.  For the Vault Vision auth platform, the access token provided can be used to make a call into our 'userinfo_endpoint' in retrieve information about the user.

### Access Token Example
See the below for the contents of the payload of an actual decoded JWT access token issued by the Vault Vision authentication flow:
```js
{
  header: {
    alg: 'RS256',
    kid: 'WLL2kcGna7HRmTawwmhWa4-XmIjyhYUnJhrjRSYpLTA',
    typ: 'JWT'
  },
  payload: {
    tc: '2023-05-22T19:47:14Z',
    u: 'U7sSR97b3g39',
    c: 'EmAhTsPWxcyC',
    e: '2023-05-22T20:47:14Z',
    s: 'openid email profile',
    t: 'gtrbTuREykUHAtkr'
  },
  signature: 'Rc4eUT8RJJp-0mKAJ9nZEhw0r-C2fBifKB4deJwBeSWzMFuxbDkbhj8MiRe002hgfEyR6DqsknWv2KK1w1ylW_7BeyvRy124fjQvn1iMvg9jR86kDgVXRM_TLKk6vtADQ9jwVHNSSMrciTy6iXHDcmUb7HFgJJqEqJBGQPqhiQnZo8Ie8VJ0YMG1qIjniEgDvfbKMI5_94tj0bvU6nTak3Zl6kKpAs-Hreqhl6NcqFJj3OmE7KlmQ8yJJOGVfQP_pklwx8N92WY6osSD-ilXH5aBgyHb_Xlck8sZFrXRUQQTIH_9k50gtrbTuREykUHIb-3rGBv4Eyrjf8AD_uGmiDw'
}
```

## UserInfo

With a proper access token, a call can be made to our 'userinfo_endpoint' to retrieve a payload of information about the current authenticated user.

The response will contain a JSON object with details about the user, specified by the [OpenID Connect Core spec](https://openid.net/specs/openid-connect-core-1_0.html#UserInfoResponse)

### UserInfo Example
See below for a UserInfo JSON response example from the Vault Vision authentication userinfo endpoint:
```js
{
  email: 'john@smith.com',
  email_verified: true,
  family_name: 'Smith',
  given_name: 'John',
  iss: 'https://auth.vaultvision.com',
  locale: 'en',
  name: 'John Smith',
  picture: 'https://lh3.googleusercontent.com/a/BeSWzMFuxbDk',
  sub: 'gtrbTuREykUH'
}
```