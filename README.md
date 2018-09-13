# Cukeness

## Basic Architectural Diagram

<img alt='block diagram show the relationship between the API server, Git server, web client, Cucumber runner, and step server' src='https://g.gravizo.com/svg?%5BAPI%20Server%5D%20as%20ApiServer%3B%0A%5BGit%5D%20as%20Git%3B%0A%5BWeb%20Client%5D%20as%20Client%3B%0A%5BCucumber%20Runner%5D%20as%20Runner%3B%0A%5BStep%20Server%5D%20as%20StepServer%3B%0AApiServer%20-left-%3E%20Runner%3B%0AApiServer%20-%3E%20Git%3B%0AClient%20-down-%3E%20ApiServer%3B%0ARunner%20-down-%3E%20StepServer%3B%0AApiServer%20-down-%3E%20StepServer%3B%0A%40enduml%3B'>

```plantuml
[API Server] as ApiServer;
[Git] as Git;
[Web Client] as Client;
[Cucumber Runner] as Runner;
[Step Server] as StepServer;
ApiServer -left-> Runner;
ApiServer -> Git;
Client -down-> ApiServer;
Runner -down-> StepServer;
ApiServer -down-> StepServer;
@enduml;
```
