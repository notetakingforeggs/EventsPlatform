# build out initial MVP with OAuth flow in the frontend primarily

### Context
There seems to be a decision to make as to how much of the login/signin to do on the front vs back end, with both being possible. 

### Decision
To use firebase sign/login flows on the frontend and pass the access tokens for the google apis to the backend.

### Alternatives Considered
Front end sends a request to back end, which sends a redirect to the frontend to initiate a signin process which occurs on the backend. 

### Consequences
- It may be less secure, and will require https setups for minimum security  
- it should be somewhat faster to implement initially, delegating more of the process to firebase (allowing multiple logins etc..) 
- It may result in technical debt that i regret later if it comes to refactoring.
- tokens may become invalid after a certain time, refresh may be harder
- offline not so easy?

### Status
Initialised

## More reading - reverse this probably :(
Front-end libraries (like Firebase Authentication or Google Sign-In) are designed for short-lived sessions and client-side use.

They do not provide a refresh token because:

Refresh tokens are long-lived and must be stored securely (e.g., on a server).

Exposing a refresh token to the front end is a security risk.

I can do a second oauth flow initiated from the backend to get the refresh token?