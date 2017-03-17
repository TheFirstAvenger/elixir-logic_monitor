defmodule LogicMonitor.MockClient do

  @moduledoc """
  Mock Client for use in testing.
  """

  #Request
  def get("https://test.logicmonitor.com/santaba/rest/headers/test?a=b&c=d",
          [timeout: 30000, headers:
                            ["Content-Type": "application/json",
                             "Authorization": "LMv1 test:NjNhNzliNmQ2NDA0NTg3MjMwNmI0M2Y4N2Q5OTRlMDQyYTE4ZGQ3OGI1NTBjZTFmOWU1NDVmZWQ1MDQ1M2FhOQ==:12345678"]]) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\":\"opts_success\"}", headers: "Some Headers"}
  end
  def get("https://test.logicmonitor.com/santaba/rest/success/success?a=b&c=d", _), do: %HTTPotion.Response{body: "{\"status\":200, \"data\":\"some_data\"}", headers: "Some Headers"}
  def get("https://test.logicmonitor.com/santaba/rest/httpotion/failure?a=b&c=d", _), do: %HTTPotion.ErrorResponse{message: "some error"}

  #Alerts

  def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=this_way&fields=a,b,c&", _) do
    %HTTPotion.Response{body: "{\"status\":200, \"data\": {\"items\": [{}, {}]}}", headers: "Some Headers"}
  end

  def get("https://test.logicmonitor.com/santaba/rest/alert/alerts?sort=that_way&fields=a,b,c&", _) do
    %HTTPotion.ErrorResponse{message: "some error"}
  end

  #ApiTokens
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

  #AuditLogs
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
