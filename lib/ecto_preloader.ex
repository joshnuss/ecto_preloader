defmodule Ecto.Preloader do
  @moduledoc """
  `Ecto.Preloader` is a module for preloading using joins.

  By default, Ecto preloads associations using a separate query for each association, which can degrade performance.

  You can make it faster by using a combination of join/preload, but that requires a bit of boilerplate.

  With `Ecto.Preloader` preloading with a join takes just one line of code.

  ## Example using Ecto join+assoc+preload

  ```
  Invoice
  |> join(:left, [i], assoc(i, :customer), as: :customer)
  |> join(:left, [i], assoc(i, :lines), as: :lines)
  |> preload([lines: l, customers: c], lines: l, customer: c)
  |> Repo.all()
  ```

  ## Example using Ecto.Preloader

  ```
  import Ecto.Preloader

  Invoice
  |> preload_join(:customer)
  |> preload_join(:lines)
  |> Repo.all()
  ```

  """

  import Ecto, only: [assoc: 2]
  alias Ecto.Query.Builder.{Join, Preload}

  defmacro preload_join(query, association) do
    expr = quote do: assoc(l, unquote(association))
    binding = quote do: [l]
    preload_bindings = quote do: [{unquote(association), x}]
    preload_expr = quote do: [{unquote(association), x}]

    query
    |> Join.build(:left, binding, expr, nil, nil, association, nil, nil, __CALLER__)
    |> elem(0)
    |> Preload.build(preload_bindings, preload_expr, __CALLER__)
  end
end
