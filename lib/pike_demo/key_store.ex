defmodule PikeDemo.KeyStore do
  use Pike.Store.ETS, table_name: :pike_demo_keys
end
