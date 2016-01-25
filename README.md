# MaruRethinkTodo

To-do List JSON API built with [Maru framework](http://maru.readme.io) and [hamiltop](github.com/hamiltop)'s [RethinkDB Elixir client](github.com/hamiltop/rethinkdb-elixir)

Tested against [Todo-Backend](http://todobackend.com/) spec

#### To Run

First, start up rethinkdb:
```sh
rethinkdb
```
Create a `tasks` table in the `test` database using the RethinkDB dashboard at localhost:8080

Then, in a separate terminal tab:
```sh
git clone https://github.com/whitfieldc/maru_rethink_todo.git
cd maru_rethink_todo
mix deps.get
iex -S mix
```
Test local version at: [http://www.todobackend.com/specs/index.html?http://localhost:8880/tasks](http://www.todobackend.com/specs/index.html?http://localhost:8880/tasks)

#### Requirements
- Elixir 1.2
- Hex
- RethinkDB


#### To Run via Docker

Sometimes it is cleaner to try a project without installing too many things.
If you already have Docker installed, this is for you.

To build the docker image, run:

```sh
make build
```

It uses the official erlang image as its base and the precompiled Elixir 1.2.1.
Check the [`Dockerfile`](./Dockerfile) for details.

To start the app run:

```sh
make install
```

It creates two containers, `maru_db` running RethinkDB 2.2 and `maru_app` runningthe Elixir service.  To ease the inspection it binds ports 8080 and 8880 for
the db GUI and the app API respectively.

Remember to create the table `tasks` under the `test` database as mentioned
above using the RethinkDB GUI.  In this case it runs on `http://<docker_machine_ip>:8080` where `docker_machine_ip` depends on how Docker has been installed.
In my case, given I use Docker Machine on MacOSX the default IP is `192.168.99.100`.  If you run Docker on top of Linux just use `localhost`.

To remove all containers run:

```sh
make clean
```
