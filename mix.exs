defmodule LogicMonitor.Mixfile do
  use Mix.Project

  def project do
    [app: :logic_monitor,
     version: "0.0.9",
     elixir: "~> 1.4",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpotion, "~> 3.0"},
     {:poison, "~> 3.1"},
     {:earmark, "~> 1.0.1", only: :dev},
     {:ex_doc, "~> 0.13.1", only: :dev}]
  end

  defp description do
    "Elixir wrapper for Logic Monitor REST api. Uses LMv1 API Token Authentication."
  end

  defp package do
    [maintainers: ["Mike Binns"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/TheFirstAvenger/elixir-logic_monitor.git"}]
  end
end
