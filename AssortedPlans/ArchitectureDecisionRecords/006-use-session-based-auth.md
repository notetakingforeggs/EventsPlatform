# Use Session based authentication 
---

### Context
I need to figure out how to both authenticate users to use the app, and be able to authorise access to their google calendar via the api 
### Decision
I am going to use session based Auth, that is passing the OAuth token to the backend, and then wrapping this in a credentials object and using it to access API services.
### Alternatives Considered
The alternative is to send the token with each request made from the frontened to the backend, and send the token in the moment, with it immediately being passed to the susequent API that will be called. The concensus seems to be that the former is preferable when making more requests to external apis
### Consequences
I will have to think more about storing and securing the keys, and dealing with refreshing the token when it expires (1h or so). It also meaans i will only send it once (at sign up), and then when it expires too maybe?
### Status
- Accepted
