defmodule PikeDemoWeb.Router do
  use PikeDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PikeDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_authed do
    plug :accepts, ["json"]

    plug Pike.AuthorizationPlug,
      store: PikeDemo.KeyStore
  end

  scope "/", PikeDemoWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # API endpoints
  scope "/api_authed", PikeDemoWeb do
    pipe_through :api_authed

    scope "/users" do
      get "/", UsersController, :index
      get "/:id", UsersController, :show
      post "/", UsersController, :create
      put "/:id", UsersController, :update
      delete "/:id", UsersController, :delete
    end

    scope "/products" do
      get "/", ProductsController, :index
      get "/:id", ProductsController, :show
      post "/", ProductsController, :create
      put "/:id", ProductsController, :update
      delete "/:id", ProductsController, :delete
    end

    scope "/orders" do
      get "/", OrdersController, :index
      get "/:id", OrdersController, :show
      post "/", OrdersController, :create
      put "/:id", OrdersController, :update
      delete "/:id", OrdersController, :delete
    end

    scope "/categories" do
      get "/", CategoriesController, :index
      get "/:id", CategoriesController, :show
      post "/", CategoriesController, :create
      put "/:id", CategoriesController, :update
      delete "/:id", CategoriesController, :delete
    end

    scope "/settings" do
      get "/", SettingsController, :index
      get "/:id", SettingsController, :show
      post "/", SettingsController, :create
      put "/:id", SettingsController, :update
      delete "/:id", SettingsController, :delete
    end
  end

  # API endpoints
  scope "/api", PikeDemoWeb do
    pipe_through :api

    scope "/users" do
      get "/", UsersController, :index
      get "/:id", UsersController, :show
      post "/", UsersController, :create
      put "/:id", UsersController, :update
      delete "/:id", UsersController, :delete
    end

    scope "/products" do
      get "/", ProductsController, :index
      get "/:id", ProductsController, :show
      post "/", ProductsController, :create
      put "/:id", ProductsController, :update
      delete "/:id", ProductsController, :delete
    end

    scope "/orders" do
      get "/", OrdersController, :index
      get "/:id", OrdersController, :show
      post "/", OrdersController, :create
      put "/:id", OrdersController, :update
      delete "/:id", OrdersController, :delete
    end

    scope "/categories" do
      get "/", CategoriesController, :index
      get "/:id", CategoriesController, :show
      post "/", CategoriesController, :create
      put "/:id", CategoriesController, :update
      delete "/:id", CategoriesController, :delete
    end

    scope "/settings" do
      get "/", SettingsController, :index
      get "/:id", SettingsController, :show
      post "/", SettingsController, :create
      put "/:id", SettingsController, :update
      delete "/:id", SettingsController, :delete
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:pike_demo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PikeDemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
