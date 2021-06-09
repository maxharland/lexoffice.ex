defmodule LexOffice.Mixfile do
  use Mix.Project

  @project_url "https://github.com/fbettag/lexoffice.ex"

  def project do
    [
      app: :lexoffice,
      version: "0.1.9",
      elixir: "~> 1.7",
      source_url: @project_url,
      homepage_url: @project_url,
      name: "lexoffice.de API",
      description: "Implements the API for invoice generation with lexoffice.de",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_add_deps: :apps_direct
      ]
    ]
  end

  defp package do
    [
      name: "lexoffice",
      maintainers: ["Franz Bettag"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url},
      files: ~w(lib LICENSE README.md mix.exs)
    ]
  end

  defp aliases do
    [credo: "credo -a --strict"]
  end

  defp deps do
    [
      {:tesla, "~> 1.3"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.17"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:doctor, "~> 0.17.0", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, github: "rrrene/credo", only: [:dev, :test]},
      {:git_hooks, "~> 0.4.0", only: [:test, :dev], runtime: false}
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end
end
