Misc "to do" list
---
- Create error handlers to gracefully handle exceptions etc
- create an sql seed/init for testing purposes
- need to robustify methods in service impls, especially update. feels jank rn.
- need to solidify what "id" is gonna be, as i think it is currently autogenned by the orm. is that an issue?q

- think about how you are going to add people to events (update attendees) and also update booked events at the same time? user clicks "book event", put request to update their events list to include the event object that they are choosing, and also a put request to modify that event to include the user? is there going to be some sort of ouroboral badness? can't quite fathom, maybe fine... Perhaps scrutinise the many to many/join table thing going on...

- Write tests for service methods and controllers
- set it up with a config file that has Strings and images that you can change and it customises your app?

- https (lets encrypt) for backend, do i need this? 

<br></br>
- adding events

- Frontend issue with not reading the deeplink if recently logged in? 

- also frontend issue where i can pop all the widgets off the stack with a back button

- update puml to make sure it is in accordance with current auth flow
- decide whether or not i can do away with firebase?
    
__backend autheentication can wait as it is secondary__
__JWT on the frontend is enough to access the backend data and make calls to the calendar__
## now
1) planning session - what is happening with the appuser shape, attendees and

- firebase for user roles - do this after the business logic


**make your model attributes have the same names between the front and backends, why are they even different you are the only person working on this project?!?**

## Tomorrow
- implement most basic form of state management, just get the below running
- super basic listview view events for user, clickable to add to your google calendar
<br>
- and then do a massive old refactor of the architecture to MVVM with provider etc...
- base it off the flutter example doc
-hange startdate enddate to start/end to include time
-change managed reference to DTOs as you dont need to have who is going to what on the frontend i dont think? or maybe yeah, to know who is going/how many