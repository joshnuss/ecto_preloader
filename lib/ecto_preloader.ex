defmodule Ecto.Preloader do
  @moduledoc """
  Ecto.Preloader is a module for preloading using joins.

  It is more efficient than calling `Ecto.Query.Repo.preload`, as that results in extra queries.

  Join/Preload combination is already supported by Ecto, but it's requires a bit of boilerplate.

  This module simplifies it a bit.

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
  alias Ecto.Query
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
