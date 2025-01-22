# build out initial MVP with OAuth flow in the frontend primarily

### Context
There seems to be a decision to make as to how much of the login/signin to do on the front vs back end, with both being possible. 

### Decision
To use firebase sign/login flows on the frontend and pass the access tokens for the google apis to the backend.

### Alternatives Considered
Front end sends a request to back end, which sends a redirect to the frontend to initiate a signin process which occurs on the backend. 

### Consequences
It may be less secure, and will require https setups for minimum security, but it should be somewhat faster, delegating more of the process to firebase (allowing multiple logins etc..) It may result in technical debt that i regret later if it comes to refactoring.

### Status
Initialised
