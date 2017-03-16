defmodule ApiTokensTest do
  use ExUnit.Case
  alias LogicMonitor.ApiTokens

  defmodule ClientMock do
    def get("https://test.logicmonitor.com/santaba/rest/setting/admins/apitokens?sort=this_way&fields=a,b,c&", _) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/admins/apitokens?sort=that_way&fields=a,b,c&", _) do
      %HTTPotion.ErrorResponse{message: "some error"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/admins/123/apitokens?", _) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
    end

    def get("https://test.logicmonitor.com/santaba/rest/setting/admins/124/apitokens?", _) do
      %HTTPotion.ErrorResponse{message: "some error"}
    end
  end

  test "all success" do
    assert ApiTokens.all([sort: "this_way", fields: "a,b,c"], ClientMock) == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "all failure" do
    assert ApiTokens.all([sort: "that_way", fields: "a,b,c"], ClientMock) == {:error, "some error"}
  end

  test "for_user success" do
    assert ApiTokens.for_user("123", [], ClientMock) == {:ok, {200, %{"items" => [%{}, %{}]}}}
  end

  test "for_user failure" do
    assert ApiTokens.for_user("124", [], ClientMock) == {:error, "some error"}
  end

end
