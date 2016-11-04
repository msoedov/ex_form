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
  
end
