defmodule EctoPreloader.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_preloader,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "> 0.3.0"},
      {:ex_doc, github: "elixir-lang/ex_doc", only: :dev, runtime: false}
    ]
  end
end
