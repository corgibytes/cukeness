# Cukeness

## Basic Architectural Diagram

<img alt='block diagram show the relationship between the API server, Git server, web client, Cucumber runner, and step server' src='https://g.gravizo.com/svg?
@startuml;
component "API Server" as ApiServer;
component "Git" as Git;
component "Web Client" as Client;
component "Cucumber Runner" as Runner;
component "Step Server" as StepServer;
ApiServer -left-> Runner;
ApiServer -> Git;
Client -down-> ApiServer;
Runner -down-> StepServer;
ApiServer -down-> StepServer;
@enduml;
'>
