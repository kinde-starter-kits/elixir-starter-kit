# Kinde Starter Kit - Elixir
This is an Elixir template with [KindeAuth](https://kinde.com/docs/developer-tools/elixir-sdk/).

## Register an account on Kinde
To get started set up an account on [Kinde](https://app.kinde.com/register).

## Setup your local environment
Clone this repo and within assets directory run this command `npm i`, then in the root directory execute `mix deps.get` to install the dependencies.

Make a copy of `.env_sample` and name it simply `.env`. Set the following variables with the details from the Kinde `App Keys` page

> KINDE_DOMAIN - The Kinde host value
>
> KINDE_REDIRECT_URL - The url that the user will be returned to after authentication
>
> KINDE_CLIENT_SECRET - The client secret
>
> KINDE_PKCE_LOGOUT_URL - The url where pkce user will be redirected upon logout
>
> KINDE_PKCE_REDIRECT_URL - The url that the pkce user will be returned to after authentication
>
> KINDE_BACKEND_CLIENT_ID - The id of your backend application
>
> KINDE_FRONTEND_CLIENT_ID - The id of your frontend application
>
> KINDE_LOGOUT_REDIRECT_URL - The url where user will be redirected upon logout

e.g

```
KINDE_DOMAIN=https://<your_subdomain>.kinde.com
KINDE_REDIRECT_URL=http://<your_domain>/callback
KINDE_CLIENT_SECRET=<your_client_secret>
KINDE_PKCE_LOGOUT_URL=<your_redirect_url>
KINDE_PKCE_REDIRECT_URL=http://<your_domain>/callback
KINDE_BACKEND_CLIENT_ID=<your_backend_client_id>
KINDE_FRONTEND_CLIENT_ID=<your_frontend_client_id>
KINDE_LOGOUT_REDIRECT_URL=<your_redirect_url>
```
## Set your Callback and Logout URLs
Your user will be redirected to Kinde to authenticate. After they have logged in or registered they will be redirected back to your Elixir application.

You need to specify in Kinde which url you would like your user to be redirected to in order to authenticate your app.

On the App Keys page set ` Allowed callback URLs` to `http://localhost:4000/callback`

> Important! This is required for your users to successfully log in to your app.

You will also need to set the url they will be redirected to upon logout. Set the `Allowed logout redirect URLs` to `http://localhost:4000`.

## Start the app

Run `mix phx.server` and navigate to http://localhost:4000 .

Click on `Sign up` and register your first user for your business!
## View users in Kinde

If you navigate to the "Users" page within Kinde you will see your newly registered user there. 🚀

Use following routes to

- Login Client Credentials (/log-in)
- Claims (/claims)
- Claim (/claim)
- Claims PKCE (/claims-pkce)
- permissions (/permissions)
- User details (/user)
- Organization (/organization)
- All Tokens (/token)
- PKCE Login (/pkce-reg)
- Call /token endpoint (/token-endpoint)
- Helper Methods (/helper_methods)
- Get Claim From ID Token (/get_claim_from_id_token)
