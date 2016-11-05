defmodule ExFormTest do
  use ExUnit.Case
  doctest ExForm

  @hook "http://requestb.in/112mjyd1"

  test "test publish" do
    r = ExForm.new |> ExForm.multiple_choice("What's going on", [
        "A", "B", "C"
        ]) |> ExForm.publish("Hallo", @hook)
    assert r.status == 201, r.body
  end

  # test "test all in once" do
  #   r = ExForm.new
  #   |> ExForm.multiple_choice("What's going on", [
  #       "A", "B", "C"
  #       ])
  #   |> ExForm.long_text("Long test here")
  #   # |> ExForm.number("Lucky number?")
  #   # |> ExForm.yes_no("Will Trump win?")
  #   # |> ExForm.opinion_scale("Rate this test?", "Crap", "Okay", "Awesome")
  #   # |> ExForm.short_text("Shorter text", max_characters = 14)
  #   # |> ExForm.rating("Whatever")
  #   |> ExForm.publish("Hallo", @hook)
  #   assert r.status == 201, r.body
  # end

end
