defmodule LogicMonitor.MockClient do

  @moduledoc """
  Mock Client for use in testing. Theory behind this approach to mocks explained by José Valim [here](http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/).
  """

  @headers %{hdrs: %{"content-type" => "application/json"}}

  #Request
  def get("https://test.logicmonitor.com/santaba/rest/headers/test?a=b&c=d",
          [timeout: 30000, headers:
                            ["Content-Type": "application/json",
                             "Authorization": "LMv1 test:NjNhNzliNmQ2NDA0NTg3MjMwNmI0M2Y4N2Q5OTRlMDQyYTE4ZGQ3OGI1NTBjZTFmOWU1NDVmZWQ1MDQ1M2FhOQ==:12345678"]]) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\":{\"total\": 2, \"items\": [\"opts\", \"success\"]}}", headers: @headers}
  end
  def get("https://test.logicmonitor.com/santaba/rest/success/success?a=b&c=d", _), do: %HTTPotion.Response{body: "{\"status\":200, \"data\":{\"total\": 2, \"items\": [\"opts\", \"success\"]}}", headers: @headers}
  def get("https://test.logicmonitor.com/santaba/rest/httpotion/failure?a=b&c=d", _), do: %HTTPotion.ErrorResponse{message: "some error"}

  #Alerts

  def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=this_way&fields=a,b,c&", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"total\": 2, \"items\": [{}, {}]}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=that_way&fields=a,b,c&", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  #ApiTokens
  def get("https://test.logicmonitor.com/santaba/rest/setting/admins/apitokens?sort=this_way&fields=a,b,c&", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"total\": 2, \"items\": [{}, {}]}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/admins/apitokens?sort=that_way&fields=a,b,c&", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/admins/123/apitokens?", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"total\": 2, \"items\": [{}, {}]}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/admins/124/apitokens?", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  #AuditLogs
  def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs?sort=this_way&fields=a,b,c&", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"total\": 2, \"items\": [{}, {}]}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs?sort=that_way&fields=a,b,c&", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs/12345?fields=a,b,c", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"id\": 1}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/setting/accesslogs/12345?fields=d,e,f", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  #Devices

  def get("https://test.logicmonitor.com/santaba/rest/device/devices?sort=this_way&fields=a,b,c&", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"total\": 2, \"items\": [{}, {}]}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/device/devices?sort=that_way&fields=a,b,c&", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  def get("https://test.logicmonitor.com/santaba/rest/device/devices/1234?fields=a,b,c", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"id\": 1}}", headers: @headers}
  end

  def get("https://test.logicmonitor.com/santaba/rest/device/devices/1234?fields=d,e,f", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end
end
