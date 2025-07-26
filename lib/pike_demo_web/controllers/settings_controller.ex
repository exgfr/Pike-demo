defmodule PikeDemoWeb.SettingsController do
  use PikeDemoWeb, :controller

  def index(conn, _params) do
    settings = [
      %{id: 1, key: "site_name", value: "Pike Demo Store", type: "string", group: "general"},
      %{id: 2, key: "theme", value: "default", type: "string", group: "appearance"},
      %{id: 3, key: "maintenance_mode", value: "false", type: "boolean", group: "system"},
      %{id: 4, key: "tax_rate", value: "7.5", type: "float", group: "store"},
      %{id: 5, key: "featured_products", value: "[1,2,3,4]", type: "json", group: "store"}
    ]
    
    json(conn, %{settings: settings, total: length(settings), status: "success"})
  end

  def show(conn, %{"id" => id}) do
    # Simulate fetching a specific setting
    setting = %{
      id: String.to_integer(id),
      key: "setting_#{id}",
      value: "value_#{id}",
      type: Enum.random(["string", "boolean", "integer", "float", "json"]),
      group: Enum.random(["general", "appearance", "system", "store", "api"]),
      description: "This is setting #{id}'s description",
      is_public: Enum.random([true, false]),
      created_at: "2023-01-#{Enum.random(1..30)}",
      updated_at: "2023-04-#{Enum.random(1..30)}"
    }
    
    json(conn, %{setting: setting, status: "success"})
  end

  def create(conn, %{"setting" => setting_params}) do
    # Simulate creating a setting
    json(conn, %{
      status: "success",
      message: "Setting created successfully",
      setting: Map.put(setting_params, "id", Enum.random(100..999))
    })
  end

  def update(conn, %{"id" => id, "setting" => setting_params}) do
    # Simulate updating a setting
    json(conn, %{
      status: "success",
      message: "Setting #{id} updated successfully",
      setting: Map.put(setting_params, "id", String.to_integer(id))
    })
  end

  def delete(conn, %{"id" => id}) do
    # Simulate deleting a setting
    json(conn, %{
      status: "success",
      message: "Setting #{id} deleted successfully"
    })
  end
end