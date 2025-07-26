# Pike Demo

This project demonstrates the usage of the Pike authorization library with a Phoenix application. It provides multiple API endpoints with authentication and authorization capabilities.

## Setup Instructions

### 1. Clone Repositories

First, create a new folder for your project and clone both Pike and Pike Demo repositories into it:

```bash
# Create a new folder
mkdir pike_project
cd pike_project

# Clone Pike repository
git clone https://github.com/your-username/pike.git

# Clone Pike Demo repository
git clone https://github.com/your-username/pike_demo.git
```

### 2. Navigate to Pike Demo

```bash
cd pike_demo
```

### 3. Install Dependencies

Install all required dependencies:

```bash
mix deps.get
```

### 4. Run the Phoenix Server

Start the Phoenix application:

```bash
mix phx.server
```

The server will be available at [http://localhost:4000](http://localhost:4000).

## API Endpoints

The application includes the following endpoints:

### Public Endpoints (No Authentication)

These endpoints are accessible without authentication at `/api/`:

#### Users Endpoints
- `GET /api/users` - List all users
- `GET /api/users/:id` - Get user details
- `POST /api/users` - Create a user
- `PUT /api/users/:id` - Update user

### Authenticated Endpoints

These endpoints require authentication at `/api_authed/`:

#### Users Endpoints
- `GET /api_authed/users` - List all users
- `GET /api_authed/users/:id` - Get user details
- `POST /api_authed/users` - Create a user
- `PUT /api_authed/users/:id` - Update user
- `DELETE /api_authed/users/:id` - Delete user

#### Products Endpoints (Require Permissions)
- `GET /api_authed/products` - List all products (Requires `Products:list` permission)
- `GET /api_authed/products/:id` - Get product details (Requires `Products:read` permission)
- `POST /api_authed/products` - Create a product (Requires `Products:create` permission)
- `PUT /api_authed/products/:id` - Update product (Requires `Products:update` permission)
- `DELETE /api_authed/products/:id` - Delete product (Requires `Products:delete` permission)

#### Orders Endpoints
- `GET /api_authed/orders` - List all orders
- `GET /api_authed/orders/:id` - Get order details
- `POST /api_authed/orders` - Create an order
- `PUT /api_authed/orders/:id` - Update order
- `DELETE /api_authed/orders/:id` - Delete order

#### Categories Endpoints
- `GET /api_authed/categories` - List all categories
- `GET /api_authed/categories/:id` - Get category details
- `POST /api_authed/categories` - Create a category
- `PUT /api_authed/categories/:id` - Update category
- `DELETE /api_authed/categories/:id` - Delete category

#### Settings Endpoints
- `GET /api_authed/settings` - List all settings
- `GET /api_authed/settings/:id` - Get setting details
- `POST /api_authed/settings` - Create a setting
- `PUT /api_authed/settings/:id` - Update setting
- `DELETE /api_authed/settings/:id` - Delete setting

## Authentication and Authorization

### Authentication

The application uses Pike's authentication system with an API key store. Authentication is implemented via the `Pike.AuthorizationPlug` plug in the router:

```elixir
pipeline :api_authed do
  plug :accepts, ["json"]
  
  plug Pike.AuthorizationPlug,
    store: PikeDemo.KeyStore
end
```

### Authorization

Only the Products controller currently implements permission-based authorization:

```elixir
defmodule PikeDemoWeb.ProductsController do
  use PikeDemoWeb, :controller
  use Pike.Authorization, resource: "Products"

  @require_permission action: :list
  def index(conn, _params) do
    # Implementation...
  end

  @require_permission action: :read
  def show(conn, %{"id" => id}) do
    # Implementation...
  end

  @require_permission action: :create
  def create(conn, %{"product" => product_params}) do
    # Implementation...
  end

  @require_permission action: :update
  def update(conn, %{"id" => id, "product" => product_params}) do
    # Implementation...
  end

  @require_permission action: :delete
  def delete(conn, %{"id" => id}) do
    # Implementation...
  end
end
```

## Testing with Authentication

To access authenticated endpoints, you'll need to include an API key in the request headers:

```
Authorization: Bearer your-api-key
```

The API key must be registered in the `PikeDemo.KeyStore` and have the appropriate permissions for the requested action.