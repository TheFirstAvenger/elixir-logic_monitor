defmodule AlertsTest do
  use ExUnit.Case
  alias LogicMonitor.Alerts

  test "all success" do
    assert Alerts.all(sort: "this_way", fields: "a,b,c") == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "all failure" do
    assert Alerts.all(sort: "that_way", fields: "a,b,c") == {:error, "some error"}
  end

end
