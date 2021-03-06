defmodule ExForm.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_form,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: "Api wrapper for Typeform",
     package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp package do
      [
        files: ["lib", "mix.exs", "README.md", "LICENSE"],
        maintainers: ["Alex Myasoedov"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/msoedov/ex_form"},
      ]
    end
  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
        {:tesla, "~> 0.5.0"},
        {:poison, ">= 1.0.0"},
        {:credo, "~> 0.4", only: [:dev, :test]},
         {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
