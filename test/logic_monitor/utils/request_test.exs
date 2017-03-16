defmodule RequestTest do
  use ExUnit.Case
  alias LogicMonitor.Request

  defmodule ClientMock do
    def get("https://test.logicmonitor.com/santaba/rest/headers/test?a=b&c=d",
            [timeout: 30000, headers:
                              ["Content-Type": "application/json",
                               "Authorization": "LMv1 test:NjNhNzliNmQ2NDA0NTg3MjMwNmI0M2Y4N2Q5OTRlMDQyYTE4ZGQ3OGI1NTBjZTFmOWU1NDVmZWQ1MDQ1M2FhOQ==:12345678"]]) do
      %HTTPotion.Response{body: "{\"status\":200, \"data\":\"opts_success\"}", headers: "Some Headers"}
    end
    def get("https://test.logicmonitor.com/santaba/rest/success/success?a=b&c=d", _), do: %HTTPotion.Response{body: "{\"status\":200, \"data\":\"some_data\"}", headers: "Some Headers"}
    def get("https://test.logicmonitor.com/santaba/rest/httpotion/failure?a=b&c=d", _), do: %HTTPotion.ErrorResponse{message: "some error"}
  end

  test "request headers" do
    assert Request.request("GET", "/headers/test", "a=b&c=d", "", ClientMock) == {:ok, {200, "opts_success"}}
  end

  test "request get success" do
    assert Request.request("GET", "/success/success", "a=b&c=d", "", ClientMock) == {:ok, {200, "some_data"}}
  end

  test "request get httpotion failure" do
    assert Request.request("GET", "/httpotion/failure", "a=b&c=d", "", ClientMock) == {:error, "some error"}
  end

  test "get headers" do
    assert Request.get("/headers/test", "a=b&c=d", ClientMock) == {:ok, {200, "opts_success"}}
  end

  test "get success" do
    assert Request.get("/success/success", "a=b&c=d", ClientMock) == {:ok, {200, "some_data"}}
  end

  test "get httpotion failure" do
    assert Request.get("/httpotion/failure", "a=b&c=d", ClientMock) == {:error, "some error"}
  end
end
