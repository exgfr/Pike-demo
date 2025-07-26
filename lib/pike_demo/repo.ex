defmodule PikeDemo.Repo do
  use Ecto.Repo,
    otp_app: :pike_demo,
    adapter: Ecto.Adapters.Postgres
end
