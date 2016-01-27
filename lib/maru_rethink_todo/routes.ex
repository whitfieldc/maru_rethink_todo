defmodule MaruRethinkTodo.Router.Homepage do
  use Maru.Router

  helpers do
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
      task = QueryWrapper.create_task(params)
      json conn, task
    end

    delete do
      tasks = QueryWrapper.delete_all_tasks
      json conn, tasks
    end

    route_param :task_id do
      get do
        task = QueryWrapper.get_task_by_id(params[:task_id])
        json conn, task
      end

      params do
        optional :title,     type: String
        optional :order,     type: Integer
        optional :completed, type: Boolean
        at_least_one_of [:title, :order, :completed]
      end
      patch do
        changeset = params |> Enum.filter(fn {_, nil} -> false
                                             _        -> true
                                          end)
                           |> Enum.into(%{})

        updated_task = QueryWrapper.update_task(params[:task_id], changeset)
        json conn, updated_task
      end

      delete do
        QueryWrapper.delete_task(params[:task_id])
        json conn, %{deleted: params[:task_id]}
      end

    end
  end
end
