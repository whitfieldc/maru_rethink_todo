defmodule MaruRethinkTodo.QueryWrapper do
  import RethinkDB.Query
  alias MaruRethinkTodo.Database

  require RethinkDB.Lambda
  import RethinkDB.Lambda

  def get_all_tasks do
    tasks = table("tasks") |> Database.run
    tasks.data
  end

  def create_task(new_task) do
    task = table("tasks") |> insert(new_task, %{return_changes: true})
                          |> Database.run

    task_id = hd(task.data["generated_keys"])
    url_included = table("tasks")
      |> get(task_id)
      |> update(lambda(fn (task) -> %{url: "/tasks/#{task_id}"} end),
                %{return_changes: true})
      |> Database.run

    hd(url_included.data["changes"])["new_val"]
  end

  def delete_all_tasks do
    tasks = table("tasks")
      |> delete
      |> Database.run
      # |> IO.inspect
  end

  def get_task_by_id(id_to_get) do
    task = table("tasks")
      |> filter(%{id: id_to_get})
      |> Database.run
      |> IO.inspect

    hd(task.data)
  end

  def update_task(id, changeset) do
    updated_task = table("tasks")
      |> get(id)
      |> update(changeset, %{return_changes: true})
      |> Database.run

    hd(updated_task.data["changes"])["new_val"]
  end

  def delete_task(id) do
    table("tasks")
      |> get(id)
      |> delete
      |> Database.run
      |> IO.inspect


  end

end
