defmodule EctoPreloader.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_preloader,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      name: "Ecto.Preloader",
      source_url: "https://github.com/joshnuss/ecto_preloader",
      homepage_url: "https://github.com/joshnuss/ecto_preloader",
      docs: [
        main: "Ecto.Preloader",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "> 0.3.0"}
    ]
  end
end
