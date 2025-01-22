Misc "to do" list
---
- Create AppUser DTO rather than passing full users around
- Create error handlers to gracefully handle exceptions etc
- create an sql seed/init for testing purposes
- need to robustify methods in service impls, especially update. feels jank rn.
- need to solidify what "id" is gonna be, as i think it is currently autogenned by the orm. is that an issue?q

- think about how you are going to add people to events (update attendees) and also update booked events at the same time? user clicks "book event", put request to update their events list to include the event object that they are choosing, and also a put request to modify that event to include the user? is there going to be some sort of ouroboral badness? can't quite fathom, maybe fine... Perhaps scrutinise the many to many/join table thing going on...

- Write tests for service methods and controllers
- decide which service methods are actually gonna get used
- set it up with a config file that has Strings and images that you can change and it customises your app?
- have it so you have one google calendar account that is admin, and can input items but not take them. makes it transferrable easily between different orgs, and reduces the need for a cms/admin
## Tomorrow! implement logout methods on one button and start to figure out how to send google token to backend etx. 