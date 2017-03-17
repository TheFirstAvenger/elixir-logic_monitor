defmodule LogicMonitor.AuditLogs do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @moduledoc """
  Provides access to the Audit Logs (formerly Access Logs) Resource as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/access-logs/get-access-log-entries/).
  """

  @all_params [:sort, :filter, :fields, :size, :offset, :searchId]
  @get_params [:fields]

  @doc """
  Returns all Api Tokens. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/access-logs/get-access-log-entries/).
  """
  @spec all([{atom, String.t}]) :: Request.request_response
  def all(query_params \\ []) do
    Request.get("/setting/accesslogs", QueryParams.convert(query_params, @all_params))
  end

  @doc """
  Returns the specified access log. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/access-logs/get-access-log-entries/).
  """
  @spec get(String.t, [{atom, String.t}]) :: Request.request_response
  def get(id, query_params \\ []) do
    Request.get("/setting/accesslogs/#{id}", QueryParams.convert(query_params, @get_params))
  end

end
