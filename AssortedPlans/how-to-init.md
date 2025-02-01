

## Similar issue to surfeillance, hacky solution for now...

1. turn init mode off in main application.properties
2. set mode to create
3. run programme to create tables
4. turn init mode on
5. set mode to update
6. run again to seed initial data
<br>_then either_
7. **a** create-drop to clear to restart
<br>
8. **b** turn off init mode so that you dont keep putting more init data into the db\q