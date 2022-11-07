Express Migration Steps
==================

## Step 1
Determine the 3 routes that will be used to:
- Start a login (usually something like ```/login```)
- Start a logout (usually something like ```/logout```)
- Receive the user after a successful signup or login (usually something like ```/oidc/auth_callback```)

## Step 2 - Create an Account at Vault Vision

Create an account at this Register location. [Register](https://manage.vaultvision.com/register)

Configure the Vault Vision tenant and application. Navigate to [Getting Started](https://manage.vaultvision.com/start)


## Step 3 - Update the application to use the determined URLs

Update the URL values in the (Vault Vision Management Panel)[https://manage.vaultvision.com/go#applications] for your application. 

## Step 4 add the OIDC open source client library

``` npm install openid-client ```



## Step copy the environment variables

Copy over the env vars from the (Vault Vision Management Panel)[https://manage.vaultvision.com/go#applications] into your react application, something like:
```
const appHostUrl = process.env.APP_HOST_URL;
const tenantFqdn = process.env.TENANT_FQDN;
const post_authorize_redirect = process.env.POST_AUTHORIZE_CALLBACK; //configure this in authorized web app redirect uris
const post_logout_callback = process.env.POST_LOGOUT_CALLBACK;
const tenantUrl = "https://" + tenantFqdn;
const redirect_uri = appHostUrl + post_authorize_redirect;
const post_logout_redirectUrl = [appHostUrl + post_logout_callback];
const client_id = process.env.CLIENT_ID;
const client_secret = process.env.CLIENT_SECRET;
```

## Step create a OIDC client using the open source library
```
Issuer.discover(tenantUrl).then( (vaultVisionIssuer) => {
  console.log('Discovered issuer %s %O', vaultVisionIssuer.issuer, vaultVisionIssuer.metadata);

  client = new vaultVisionIssuer.Client({
    client_id: client_id,
    client_secret: client_secret,
    redirect_uris: [redirect_uri],
    response_types: ['code'],
    // id_token_signed_response_alg (default "RS256")
    // token_endpoint_auth_method (default "client_secret_basic")
  });

});
```

## Step create a login route

Something similar to
```
// create the login get and post routes
app.get('/login', (req, res) => {
  console.log('Inside GET /login callback function')
  console.log(req.sessionID)

  const nonce = generators.nonce();
  const state = generators.state();
  const code_verifier = generators.codeVerifier();
  req.session.code_verifier = code_verifier
  req.session.nonce = nonce
  req.session.state = state

  const code_challenge = generators.codeChallenge(code_verifier);

  let redirectURL = client.authorizationUrl({
    scope: 'openid email profile',
    resource: redirect_uri,
    code_challenge,
    code_challenge_method: 'S256',
    nonce: nonce,
    state: state,
  });
  console.log("redirctURL: " + redirectURL)
  res.redirect(redirectURL)
})
```

## Step create a logout route
```
app.get('/logout', (req, res) => {
  res.clearCookie("jwt");
  res.redirect('/');
})
```

## Step create a callback route
```
app.all(post_authorize_redirect, (req, res) => {
  console.log('Inside GET /postauthorize callback function')
  console.log("request session id: " + req.sessionID)
  const params = client.callbackParams(req);
  console.log(params);
  client.callback(
    redirect_uri,
    params,
    { 
      code_verifier: req.session.code_verifier,
      state: req.session.state,
      nonce: req.session.nonce,
    }
  )
  .then( (tokenSet) => {
    req.session.sessionTokens = tokenSet;
    req.session.claims = tokenSet.claims();
    console.log('received and validated tokens %j', tokenSet);
    console.log("-------")
    console.log('validated ID Token claims %j', tokenSet.claims());

    if (tokenSet.access_token) {
      client.userinfo(tokenSet.access_token)
      .then((userinfo) => {
        req.session.userinfo = userinfo
        userLookup[userinfo.sub] = userinfo.name
        console.log("userinfo")
        console.log(userinfo)
      })
    }

    res.cookie("jwt", JSON.stringify(tokenSet.id_token), {
      secure: false,
      httpOnly: true,
      expires: 0
    });    
    res.redirect("/room.html");
      
  })

})

```

## Step import users, and assign a new forigen key
Once users are imported into the Vault Vision tenant, take the returned table of users with the new assign Vault Vision subscriberId and attach that as a forigen key into your user table.

## Step update any session creation and tear down
New user sessions should be created in the oidc callback, and destroyed in the start logout route.