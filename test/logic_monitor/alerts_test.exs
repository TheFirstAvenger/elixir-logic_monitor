defmodule AlertsTest do
  use ExUnit.Case
  alias LogicMonitor.Alerts

  defmodule ClientMock do
    def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=this_way&fields=a,b,c&", _) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=that_way&fields=a,b,c&", _) do
      %HTTPotion.ErrorResponse{message: "some error"}
    end
  end

  test "all success" do
    assert Alerts.all([sort: "this_way", fields: "a,b,c"], ClientMock) == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "all failure" do
    assert Alerts.all([sort: "that_way", fields: "a,b,c"], ClientMock) == {:error, "some error"}
  end

end
