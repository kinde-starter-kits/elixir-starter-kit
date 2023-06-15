# Kinde ELixir SDK Starter Kit

Install erlang and elixir.

Update :kinde_sdk config in `config/config.exs`.

Within assets directory run

```ssh
npm install
```
Then execute following in your terminal to run:

```ssh
mix deps.get
mix phx.server
```

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