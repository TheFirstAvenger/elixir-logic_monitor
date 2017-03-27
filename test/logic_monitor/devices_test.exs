defmodule DevicesTest do
  use ExUnit.Case
  alias LogicMonitor.Devices

  test "all success" do
    assert Devices.all(sort: "this_way", fields: "a,b,c") == {:ok, {200, [%{}, %{}]}}
  end

  test "all failure" do
    assert Devices.all(sort: "that_way", fields: "a,b,c") == {:error, "some error"}
  end

  test "all! success" do
    assert Devices.all!(sort: "this_way", fields: "a,b,c") == [%{}, %{}]
  end

  test "all! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.Devices.all!: \"some error\"", fn -> Devices.all!(sort: "that_way", fields: "a,b,c") end
  end

  test "get success" do
    assert Devices.get("1234", fields: "a,b,c") == {:ok, {200, %{"id" => 1}}}
  end

  test "get failure" do
    assert Devices.get("1234", fields: "d,e,f") == {:error, "some error"}
  end

  test "get! success" do
    assert Devices.get!("1234", fields: "a,b,c") == %{"id" => 1}
  end

  test "get! failure" do
    assert_raise RuntimeError, "Error in Elixir.LogicMonitor.Devices.get!: \"some error\"", fn -> Devices.get!("1234", fields: "d,e,f") end
  end

end
