defmodule AuditLogsTest do
  use ExUnit.Case
  alias LogicMonitor.AuditLogs

  defmodule ClientMock do
    def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs?sort=this_way&fields=a,b,c&", _) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs?sort=that_way&fields=a,b,c&", _) do
      %HTTPotion.ErrorResponse{message: "some error"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs/12345?fields=a,b,c", _) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs/12345?fields=d,e,f", _) do
      %HTTPotion.ErrorResponse{message: "some error"}
    end
  end

  test "all success" do
    assert AuditLogs.all([sort: "this_way", fields: "a,b,c"], ClientMock) == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "all failure" do
    assert AuditLogs.all([sort: "that_way", fields: "a,b,c"], ClientMock) == {:error, "some error"}
  end

  test "get success" do
    assert AuditLogs.get("12345", [fields: "a,b,c"], ClientMock) == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "get failure" do
    assert AuditLogs.get("12345", [fields: "d,e,f"], ClientMock) == {:error, "some error"}
  end

end
