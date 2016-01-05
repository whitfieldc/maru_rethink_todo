# MaruTodo

To-do List JSON API built with [Maru framework](http://maru.readme.io)

Tested against [Todo-Backend](http://todobackend.com/) spec

#### To Run

First, start up rethinkdb:
```sh
rethinkdb
```
Create a table `tasks` using the RethinkDB dashboard at localhost:8080

Then, in a separate terminal tab:
```sh
git clone https://github.com/whitfieldc/maru_todo.git
cd maru_todo
mix deps.get
iex -S mix
```
Test local version at [http://www.todobackend.com/specs/index.html?http://localhost:8880/tasks](http://www.todobackend.com/specs/index.html?http://localhost:8880/tasks)

#### Requirements
- Elixir 1.2
- Hex
- RethinkDB
