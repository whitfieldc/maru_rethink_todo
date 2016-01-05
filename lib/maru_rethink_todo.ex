defmodule MaruRethinkTodo do
  use Application

  def start(_type, _args) do
    MaruRethinkTodo.Supervisor.start_link
  end

end
