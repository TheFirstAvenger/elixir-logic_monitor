defmodule ApiTokensTest do
  use ExUnit.Case
  alias LogicMonitor.ApiTokens

  test "all success" do
    assert ApiTokens.all(sort: "this_way", fields: "a,b,c") == {:ok, {200, [%{}, %{}]}}
  end

  test "all failure" do
    assert ApiTokens.all(sort: "that_way", fields: "a,b,c") == {:error, "some error"}
  end

  test "all! success" do
    assert ApiTokens.all!(sort: "this_way", fields: "a,b,c") == [%{}, %{}]
  end

  test "all! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.ApiTokens.all!: \"some error\"", fn -> ApiTokens.all!(sort: "that_way", fields: "a,b,c") end
  end

  test "for_user success" do
    assert ApiTokens.for_user("123") == {:ok, {200, [%{}, %{}]}}
  end

  test "for_user failure" do
    assert ApiTokens.for_user("124") == {:error, "some error"}
  end

  test "for_user! success" do
    assert ApiTokens.for_user!("123") == [%{}, %{}]
  end

  test "for_user! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.ApiTokens.for_user!: \"some error\"", fn -> ApiTokens.for_user!("124") end
  end

end
