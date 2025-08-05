defmodule PikeDemoWeb.DebugController do
  use PikeDemoWeb, :controller
  use Pike.Authorization, resource: "Debug"

  @require_permission action: :read
  def debug(conn, _params) do
    key = conn.assigns[:pike_api_key]

    # Direct test of permission check
    health_permission = Pike.action?(key, resource: "Health", action: :read)
    debug_permission = Pike.action?(key, resource: "Debug", action: :read)

    # Debug info about the key
    key_info = %{
      key: key.key,
      enabled: key.enabled,
      permissions: key.permissions,
      has_health_permission: health_permission,
      has_debug_permission: debug_permission,
      store_module: Application.get_env(:pike, :store)
    }

    json(conn, key_info)
  end
end
