defmodule PikeDemo.DevBootHook do
  @moduledoc """
  Provides functionality that runs during application boot in development environment.
  """

  @doc """
  Function called on application boot in development environment.
  Add any development setup or initialization logic here.
  """
  @spec run() :: :ok
  def run do
    IO.puts("🚀 Development environment boot hook executing...")

    PikeDemo.KeyStore.init()

    PikeDemo.KeyStore.insert(%{
      key: "abc123",
      enabled: true,
      permissions: [
        %{resource: "Debug", scopes: [:read]},
        %{resource: "Health", scopes: [:read]},
        %{resource: "Products", scopes: [:read, :write]}
      ]
    })

    PikeDemo.KeyStore.insert(%{
      key: "abc",
      enabled: true,
      permissions: [
        %{resource: "Products", scopes: [:read, :write]}
      ]
    })

    PikeDemo.KeyStore.insert(%{
      key: "a",
      enabled: true,
      permissions: []
    })

    # Add any dev environment setup logic here
    # Examples:
    # - Set up test data
    # - Initialize development services
    # - Print useful development information

    IO.puts("✅ Development boot hook completed")
    :ok
  end
end
