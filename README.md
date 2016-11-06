# ExForm

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/msoedov/ex_form/blob/master/LICENSE)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/msoedov/ex_form.svg)](https://beta.hexfaktor.org/github/msoedov/ex_form)
[![Inline docs](https://inch-ci.org/github/msoedov/ex_form.svg?branch=master)](https://inch-ci.org/github/msoedov/ex_form) [![Hex Version](https://img.shields.io/hexpm/v/ex_form.svg)](https://hex.pm/packages/ex_form)
[![Code TriagersBadge](https://www.codetriage.com/msoedov/ex_form/badges/users.svg)](https://www.codetriage.com/msoedov/ex_form)

Simplistic api wrapper for Typeform api without abusing macro/dsl.

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
{:ok, form} = ExForm.new
|> ExForm.short_text("A short text", max_characters = 14)
|> ExForm.long_text("Long text here")
|> ExForm.yes_no("Will Trump win?")
|> ExForm.number("Lucky number?")
|> ExForm.opinion_scale("Rate this test?", "Could be better", "Okay", "Awesome")
|> ExForm.rating("Whatever")
|> ExForm.publish("Awesome form tittle", "http://requestb.in/112mjyd1")

iex> form
%{"_links" => [%{"href" => "https://api.typeform.io/v0.4/forms/xd6ZCNMK3h", "rel" => "self"}, %{"href" => "https://forms.typeform.io/to/JHSAzF4qLb", "rel" => "form_render"}, %{"href" => "https://api.typeform.io/v0.4/urls/JHSAzF4qLb", "rel" => "url"}], "fields" => [%{"id" => 49056886, "max_characters" => 14, "question" => "A short text", "type" => "short_text"}, %{"id" => 49056887, "question" => "Long text here", "type" => "long_text"}, %{"id" => 49056888, "question" => "Will Trump win?", "type" => "yes_no"}, %{"id" => 49056889, "question" => "Lucky number?", "type" => "number"}, %{"id" => 49056890, "labels" => %{"center" => "Okay", "left" => "Could be better", "right" => "Awesome"}, "question" => "Rate this test?", "steps" => 11, "type" => "opinion_scale"}, %{"id" => 49056891, "question" => "Whatever", "shape" => "star", "steps" => 5, "type" => "rating"}], "id" => "xd6ZCNMK3h", "tags" => ["deafult"], "title" => "Awesome form tittle", "urls" => [%{"form_id" => "xd6ZCNMK3h", "id" => "JHSAzF4qLb", "version" => "v0.4"}], "version" => "v0.4", "webhook_submit_url" => "http://requestb.in/112mjyd1"}
```

Just build and prepare
```elixir
form_payload = ExForm.new
|> ExForm.short_text("A short text", max_characters = 14)
|> ExForm.long_text("Long text here")
|> ExForm.yes_no("Will Trump win?")
|> ExForm.number("Lucky number?")
|> ExForm.opinion_scale("Rate this test?", "Could be better", "Okay", "Awesome")
|> ExForm.rating("Whatever")
|> ExForm.build("Awesome form tittle", "http://requestb.in/112mjyd1")

```


## Configuration

In order to run `TYPE_SECRET` should be set in env
```bash
export TYPE_SECRET=key-goes-here

```
