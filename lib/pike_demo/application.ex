defmodule PikeDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PikeDemoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:pike_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PikeDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PikeDemo.Finch},
      # Start a worker by calling: PikeDemo.Worker.start_link(arg)
      # {PikeDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      PikeDemoWeb.Endpoint
    ]

    PikeDemo.DevBootHook.run()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PikeDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PikeDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
