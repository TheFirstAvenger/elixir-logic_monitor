defmodule RequestTest do
  use ExUnit.Case
  alias LogicMonitor.Request

  test "request headers" do
    assert Request.request("GET", "/headers/test", "a=b&c=d", "") == {:ok, {200, %{"items" => ["opts", "success"], "total" => 2}}}
  end

  test "request get success" do
    assert Request.request("GET", "/success/success", "a=b&c=d", "") == {:ok, {200, %{"items" => ["opts", "success"], "total" => 2}}}
  end

  test "request get httpotion failure" do
    assert Request.request("GET", "/httpotion/failure", "a=b&c=d", "") == {:error, "some error"}
  end

  test "get headers" do
    assert Request.get_all("/headers/test", "a=b&c=d") == {:ok, {200, ["opts", "success"]}}
  end

  test "get success" do
    assert Request.get_all("/success/success", "a=b&c=d") == {:ok, {200, ["opts", "success"]}}
  end

  test "get httpotion failure" do
    assert Request.get_all("/httpotion/failure", "a=b&c=d") == {:error, "some error"}
  end
end
