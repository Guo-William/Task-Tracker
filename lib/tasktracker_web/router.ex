defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    # After fetch_session in the browser pipeline:
    plug(:get_current_user)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  # Below the pipeline
  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Tasktracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TasktrackerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/users", UserController)
    resources("/tasks", TaskController)

    resources "/tasks", TaskController do
      get("/team", TaskController, :team, as: :team)
    end

    # boiler code from https://github.com/NatTuck/microblog
    post("/session", SessionController, :create)
    delete("/session", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  scope "/api", TasktrackerWeb do
    pipe_through(:api)
    resources("/manages", ManageController, except: [:new, :edit])
    resources("/timeblocks", TimeBlockController, except: [:new, :edit])
  end
end
