# Cukeness

## Basic Architectural Diagram

<img alt='block diagram show the relationship between the API server, Git server, web client, Cucumber runner, and step server' src='https://g.gravizo.com/svg?%5BAPI%20Server%5D%20as%20ApiServer%3B%0A%5BGit%5D%20as%20Git%3B%0A%5BWeb%20Client%5D%20as%20Client%3B%0A%5BCucumber%20Runner%5D%20as%20Runner%3B%0A%5BStep%20Server%5D%20as%20StepServer%3B%0AApiServer%20-left-%3E%20Runner%3B%0AApiServer%20-%3E%20Git%3B%0AClient%20-down-%3E%20ApiServer%3B%0ARunner%20-down-%3E%20StepServer%3B%0AApiServer%20-down-%3E%20StepServer%3B%0A%40enduml%3B'>

```plantuml
@startuml
[API Server] as ApiServer
[Git] as Git
[Web Client] as Client
[Cucumber Runner] as Runner
[Step Server] as StepServer
ApiServer -left-> Runner
ApiServer -> Git
Client -down-> ApiServer
Runner -down-> StepServer
ApiServer -down-> StepServer
@enduml
```

## Getting Started

Start the current version of the API Server and the Step Server.

```
docker-compose up
```

In a different terminal window start a bash session for the Runner, to test running `cucumber` with it talking to the Step Server.

```
docker-compose run runner cucumber
```

Eventually starting the Cunner is something that will be controlled by an end-point via the API Server, but for now, we're focused on getting the Step Server functional enough so that it works for our purposes.

## What We're Building

We're working on building out a server side implementation of the Cucumber Wire protocol. That will run in the `step-server` container.
