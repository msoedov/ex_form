# ExForm

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)]()


An api wrapper for Typeform api.
For more information about api check [Typeform docs](http://docs.typeform.io/)

## Link for API key
Sign up for [one here](http://docs.typeform.io/page/signup).


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_form` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_form, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_form` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_form]]
    end
    ```

## Examples

```elixir
r = ExForm.new
|> ExForm.multiple_choice("What's going on", ["A", "B", "C"])
|> ExForm.short_text("Shorter text", max_characters = 14)
|> ExForm.short_text("Shorter text default")
|> ExForm.long_text("Long test here")
|> ExForm.yes_no("Will Trump win?")
|> ExForm.number("Lucky number?")
|> ExForm.opinion_scale("Rate this test?", "Crap", "Okay", "Awesome")
|> ExForm.rating("Whatever")
|> ExForm.publish("Hallo", "http://requestb.in/112mjyd1")
```
