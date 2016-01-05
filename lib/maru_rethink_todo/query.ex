defmodule MaruRethinkTodo.QueryWrapper do
  import RethinkDB.Query
  alias MaruRethinkTodo.Database

  def get_all_tasks do
    posts = table("tasks")
      |> Database.run
    posts.data
  end

end