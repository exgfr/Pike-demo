defmodule PikeDemoWeb.CategoriesController do
  use PikeDemoWeb, :controller

  def index(conn, _params) do
    categories = [
      %{id: 1, name: "Electronics", slug: "electronics", product_count: 150, parent_id: nil},
      %{id: 2, name: "Clothing", slug: "clothing", product_count: 200, parent_id: nil},
      %{id: 3, name: "Books", slug: "books", product_count: 100, parent_id: nil},
      %{id: 4, name: "Home & Garden", slug: "home-garden", product_count: 120, parent_id: nil},
      %{id: 5, name: "Smartphones", slug: "smartphones", product_count: 50, parent_id: 1}
    ]
    
    json(conn, %{categories: categories, total: length(categories), status: "success"})
  end

  def show(conn, %{"id" => id}) do
    # Simulate fetching a specific category
    category = %{
      id: String.to_integer(id),
      name: "Category #{id}",
      slug: "category-#{id}",
      description: "This is category #{id}'s detailed description",
      meta: %{
        title: "Category #{id} | Store",
        description: "Browse our selection of Category #{id} products",
        keywords: "category #{id}, products, shop"
      },
      image: "https://example.com/categories/#{id}.jpg",
      product_count: Enum.random(10..500),
      subcategories: [
        %{id: String.to_integer(id) * 10 + 1, name: "Subcategory #{String.to_integer(id)}-1"},
        %{id: String.to_integer(id) * 10 + 2, name: "Subcategory #{String.to_integer(id)}-2"}
      ]
    }
    
    json(conn, %{category: category, status: "success"})
  end

  def create(conn, %{"category" => category_params}) do
    # Simulate creating a category
    json(conn, %{
      status: "success",
      message: "Category created successfully",
      category: Map.put(category_params, "id", Enum.random(100..999))
    })
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    # Simulate updating a category
    json(conn, %{
      status: "success",
      message: "Category #{id} updated successfully",
      category: Map.put(category_params, "id", String.to_integer(id))
    })
  end

  def delete(conn, %{"id" => id}) do
    # Simulate deleting a category
    json(conn, %{
      status: "success",
      message: "Category #{id} deleted successfully"
    })
  end
end