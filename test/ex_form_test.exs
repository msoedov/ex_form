defmodule ExFormTest do
  use ExUnit.Case
  doctest ExForm

  test "test publish" do
    r = ExForm.publish([], nil, nil)
    assert r.status == 200
  end
end
