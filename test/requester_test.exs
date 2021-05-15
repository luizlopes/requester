defmodule RequesterTest do
  use ExUnit.Case
  doctest Requester

  test "greets the world" do
    assert Requester.hello() == :world
  end
end
