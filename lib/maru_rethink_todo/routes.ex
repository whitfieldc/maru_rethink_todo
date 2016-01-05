defmodule MaruRethinkTodo.Router.Homepage do
  use Maru.Router

  helpers do
    alias MaruRethinkTodo.Task, warn: false
    alias MaruRethinkTodo.QueryWrapper, warn: false
  end

  namespace :tasks do
    get do

      tasks = QueryWrapper.get_all_tasks
      json conn, tasks
    end

    params do
      requires :title,     type: String
      optional :order,     type: Integer
      optional :completed, type: Boolean, default: false
    end
    post do
        # IO.inspect(params)
        task = QueryWrapper.create_task(params)

        json conn, task
    #   changeset = Task.changeset(%Task{}, params)
    #   case Database.insert(changeset) do
    #     {:ok, task} ->
    #       json conn, %{
    #         title: task.title,
    #         completed: task.completed,
    #         order: task.order,
    #         id: task.id,
    #         url: "http://localhost:8880/tasks/#{task.id}",
    #       }
    #     {:error, _changeset} ->
    #       conn
    #       |> put_status(400)
    #       |> text("Insert Failed")
    #   end
    end

    delete do
        task = QueryWrapper.delete_all_tasks
        json conn, []
    #   case Database.delete_all(Task) do
    #     {_number, nil} ->
    #       json conn, []
    #     _ ->
    #       conn
    #       |> put_status(500)
    #       |> text("Delete Failed")
    #   end
    end

    route_param :task_id do
      get do

        task = QueryWrapper.get_task_by_id(params[:task_id])

        json conn, task
    #     task = MaruRethinkTodo.Task |> Database.get(params[:task_id])
    #     json conn, task
      end

    #   params do
    #     optional :title,     type: String
    #     optional :order,     type: Integer
    #     optional :completed, type: Boolean
    #     at_least_one_of [:title, :order, :completed]
    #   end
    #   patch do
    #     # Next version of Maru will NOT keep nil params
    #     changeset =
    #       params |> Enum.filter(fn
    #         {_, nil} -> false
    #         _        -> true
    #       end) |> Enum.into(%{})
    #     task = MaruRethinkTodo.Task |> Database.get(params[:task_id])
    #     patch_changeset = Task.changeset(task, changeset)

    #     case MaruRethinkTodo.Database.update(patch_changeset) do
    #       {:ok, task} ->
    #         json conn, task
    #       {:error, _changeset} ->
    #         conn
    #         |> put_status(500)
    #         |> text("Update Failed")
    #     end
    #   end

    #   delete do
    #     dead_task = MaruRethinkTodo.Task |> Database.get(params[:task_id])
    #     case Database.delete(dead_task) do
    #       {:ok, task} ->
    #         json conn, task
    #       _ ->
    #         conn
    #         |> put_status(500)
    #         |> text("Delete Failed")
    #     end
    #   end

    end
  end
end
