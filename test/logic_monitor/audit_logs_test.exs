defmodule AuditLogsTest do
  use ExUnit.Case
  alias LogicMonitor.AuditLogs

  test "all success" do
    assert AuditLogs.all(sort: "this_way", fields: "a,b,c") == {:ok, {200, [%{}, %{}]}}
  end

  test "all failure" do
    assert AuditLogs.all(sort: "that_way", fields: "a,b,c") == {:error, "some error"}
  end

  test "all! success" do
    assert AuditLogs.all!(sort: "this_way", fields: "a,b,c") == [%{}, %{}]
  end

  test "all! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.AuditLogs.all!: \"some error\"", fn -> AuditLogs.all!(sort: "that_way", fields: "a,b,c") end
  end

  test "get success" do
    assert AuditLogs.get("12345", fields: "a,b,c") == {:ok, {200, [%{}, %{}]}}
  end

  test "get failure" do
    assert AuditLogs.get("12345", fields: "d,e,f") == {:error, "some error"}
  end

  test "get! success" do
    assert AuditLogs.get!("12345", fields: "a,b,c") == [%{}, %{}]
  end

  test "get! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.AuditLogs.get!: \"some error\"", fn -> AuditLogs.get!("12345", fields: "d,e,f") == {:error, "some error"} end
  end

end
