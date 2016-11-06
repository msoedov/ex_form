defmodule ExFormTest do
  use ExUnit.Case
  doctest ExForm

  @hook "http://requestb.in/112mjyd1"

  test "test publish" do
    r = ExForm.new |> ExForm.multiple_choice("What's going on", [
        "A", "B", "C"
        ]) |> ExForm.publish("Hallo", @hook)

    assert match?({:ok, p}, r)
  end

  test "test all in once" do
    r = ExForm.new
    |> ExForm.short_text("A short text", max_characters = 14)
    |> ExForm.long_text("Long text here")
    |> ExForm.yes_no("Will Trump win?")
    |> ExForm.number("Lucky number?")
    |> ExForm.opinion_scale("Rate this test?", "Could be better", "Okay", "Awesome")
    |> ExForm.rating("Whatever")
    |> ExForm.publish("Awesome form tittle", @hook)
    assert match?({:ok, p}, r)
  end

end
