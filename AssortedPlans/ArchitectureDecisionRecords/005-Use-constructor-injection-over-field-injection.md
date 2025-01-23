"Every time you use @Autowired on a field, a unit test dies." - Josh Long

On a more serious note though, you can always make your dependencies final and use lomboks @requiredargsconstructor annotation which gives you the best from both worlds. You dont have to adjust constructor manually every time you add a new dependency, but it is still there so there is no issue with testing

# Use constructor injection over field injection

### Context
Having learnt Spring using field injection, I have read that it is now depracated

### Decision
To refactor existing code and continue to use constructor injection explicitly

### Alternatives Considered
Continuing to use field injection (more familiar and slightly less code written), maybe this thing with lombok? seeing as i am using it already...


### Consequences
Adhering to current best practices, should make unit testing easier I hope

### Status
Initialised
