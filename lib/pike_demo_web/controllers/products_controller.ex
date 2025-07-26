defmodule PikeDemoWeb.ProductsController do
  use PikeDemoWeb, :controller
  use Pike.Authorization, resource: "Products"

  @require_permission action: :list
  def index(conn, _params) do
    products = [
      %{id: 1, name: "Laptop", price: 999.99, category_id: 1, stock: 50, featured: true},
      %{id: 2, name: "Smartphone", price: 699.99, category_id: 1, stock: 100, featured: true},
      %{id: 3, name: "Headphones", price: 199.99, category_id: 2, stock: 200, featured: false}
    ]

    json(conn, %{products: products, total: length(products), status: "success"})
  end

  @require_permission action: :read
  def show(conn, %{"id" => id}) do
    # Simulate fetching a specific product
    product = %{
      id: String.to_integer(id),
      name: "Product #{id}",
      price: 100.0 * String.to_integer(id),
      description: "This is product #{id}'s detailed description",
      specifications: %{
        weight: "#{Enum.random(1..5)} kg",
        dimensions: "#{Enum.random(10..30)}x#{Enum.random(10..30)}x#{Enum.random(2..10)} cm",
        color: Enum.random(["Black", "White", "Silver", "Blue"])
      },
      stock: Enum.random(0..100),
      images: [
        "https://example.com/products/#{id}/image1.jpg",
        "https://example.com/products/#{id}/image2.jpg"
      ]
    }

    json(conn, %{product: product, status: "success"})
  end

  @require_permission action: :create
  def create(conn, %{"product" => product_params}) do
    # Simulate creating a product
    json(conn, %{
      status: "success",
      message: "Product created successfully",
      product: Map.put(product_params, "id", Enum.random(100..999))
    })
  end

  @require_permission action: :update
  def update(conn, %{"id" => id, "product" => product_params}) do
    # Simulate updating a product
    json(conn, %{
      status: "success",
      message: "Product #{id} updated successfully",
      product: Map.put(product_params, "id", String.to_integer(id))
    })
  end

  @require_permission action: :delete
  def delete(conn, %{"id" => id}) do
    # Simulate deleting a product
    json(conn, %{
      status: "success",
      message: "Product #{id} deleted successfully"
    })
  end
end
