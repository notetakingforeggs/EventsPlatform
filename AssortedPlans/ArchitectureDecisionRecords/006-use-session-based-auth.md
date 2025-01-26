# Use Session based authentication 
---

### Context
I need to figure out how to both authenticate users to use the app, and be able to authorise access to their google calendar via the api 
### Decision
I am going to use session based Auth, ~~that is passing the OAuth token to the backend, and then wrapping this in a credentials object and using it to access API services.~~, meaning i will need to persist refresh tokens in the back end therefore, i need to do an OAUTH flow in the backend. To allow firebase to handle multiple different authorisations i will also do one in the frontend..
### Alternatives Considered
The alternative is to send the token with each request made from the frontened to the backend, and send the token in the moment, with it immediately being passed to the susequent API that will be called. The concensus seems to be that the former is preferable when making more requests to external apis. Firebase assumes that there is not much backend stuff going on? or is optimised for client side authroisation or something
### Consequences
I will have to think more about storing and securing the keys, and dealing with refreshing the token when it expires (1h or so). ~~It also meaas i will only send it once (at sign up), and then when it expires too maybe?~~
### Status
- Accepted
