defmodule PikeDemoWeb.UsersController do
  use PikeDemoWeb, :controller

  def index(conn, _params) do
    users = [
      %{id: 1, name: "John Doe", email: "john@example.com", role: "admin", created_at: "2023-01-15"},
      %{id: 2, name: "Jane Smith", email: "jane@example.com", role: "user", created_at: "2023-02-20"},
      %{id: 3, name: "Bob Johnson", email: "bob@example.com", role: "user", created_at: "2023-03-10"}
    ]
    
    json(conn, %{users: users, total: length(users), status: "success"})
  end

  def show(conn, %{"id" => id}) do
    # Simulate fetching a specific user
    user = %{
      id: String.to_integer(id),
      name: "User #{id}",
      email: "user#{id}@example.com",
      role: "user",
      created_at: "2023-01-15",
      profile: %{
        bio: "This is user #{id}'s bio",
        location: "City #{id}",
        website: "https://user#{id}.example.com"
      }
    }
    
    json(conn, %{user: user, status: "success"})
  end

  def create(conn, %{"user" => user_params}) do
    # Simulate creating a user
    json(conn, %{
      status: "success",
      message: "User created successfully",
      user: Map.put(user_params, "id", Enum.random(100..999))
    })
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    # Simulate updating a user
    json(conn, %{
      status: "success",
      message: "User #{id} updated successfully",
      user: Map.put(user_params, "id", String.to_integer(id))
    })
  end

  def delete(conn, %{"id" => id}) do
    # Simulate deleting a user
    json(conn, %{
      status: "success",
      message: "User #{id} deleted successfully"
    })
  end
end