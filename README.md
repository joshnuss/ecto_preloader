# Ecto.Preloader

Preload your associations efficiently by with joins.

You can do this with Ecto alone, it just requires more code. This package makes it a one liner.

Full documentation: [https://hexdocs.pm/ecto_preloader](https://hexdocs.pm/ecto_preloader).

## Example usage:

```elixir
import Ecto.Preloader

Invoice
|> preload_join(:customer)
|> preload_join(:lines)
|> Repo.all()
```

### Example using Ecto directly:

Without Ecto.Preloader it gets a bit repetitive:

```elixir
Invoice
|> join(:left, [i], assoc(i, :customer), as: :customer)
|> join(:left, [i], assoc(i, :lines), as: :lines)
|> preload([lines: l, customers: c], lines: l, customer: c)
|> Repo.all()
```

## Installation

The package can be installed by adding `ecto_preloader` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_preloader, "~> 0.1.0"}
  ]
end
```

## License

WTFPL
