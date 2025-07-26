defmodule PikeDemoWeb.OrdersController do
  use PikeDemoWeb, :controller

  def index(conn, _params) do
    orders = [
      %{id: 1, user_id: 1, total: 1299.98, status: "completed", payment_method: "credit_card", created_at: "2023-04-15"},
      %{id: 2, user_id: 2, total: 699.99, status: "processing", payment_method: "paypal", created_at: "2023-04-16"},
      %{id: 3, user_id: 1, total: 199.99, status: "shipped", payment_method: "credit_card", created_at: "2023-04-17"}
    ]
    
    json(conn, %{orders: orders, total: length(orders), status: "success"})
  end

  def show(conn, %{"id" => id}) do
    # Simulate fetching a specific order
    order = %{
      id: String.to_integer(id),
      user_id: Enum.random(1..5),
      status: Enum.random(["pending", "processing", "shipped", "completed"]),
      total: Float.round(Enum.random(100..1000) / 1, 2),
      items: [
        %{product_id: Enum.random(1..10), name: "Product Item 1", price: 99.99, quantity: 2},
        %{product_id: Enum.random(1..10), name: "Product Item 2", price: 49.99, quantity: 1}
      ],
      shipping_address: %{
        street: "123 Main St",
        city: "Example City",
        state: "EX",
        zip: "12345"
      },
      tracking_number: "TRK#{String.to_integer(id)}#{Enum.random(10000..99999)}",
      created_at: "2023-04-#{Enum.random(1..30)}"
    }
    
    json(conn, %{order: order, status: "success"})
  end

  def create(conn, %{"order" => order_params}) do
    # Simulate creating an order
    json(conn, %{
      status: "success",
      message: "Order created successfully",
      order: Map.put(order_params, "id", Enum.random(100..999))
    })
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    # Simulate updating an order
    json(conn, %{
      status: "success",
      message: "Order #{id} updated successfully",
      order: Map.put(order_params, "id", String.to_integer(id))
    })
  end

  def delete(conn, %{"id" => id}) do
    # Simulate deleting an order
    json(conn, %{
      status: "success",
      message: "Order #{id} deleted successfully"
    })
  end
end