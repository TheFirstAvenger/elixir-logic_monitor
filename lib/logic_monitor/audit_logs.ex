defmodule LogicMonitor.AuditLogs do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @all_params [:sort, :filter, :fields, :size, :offset, :searchId]
  @get_params [:fields]

  def all(query_params \\ [], client \\ HTTPotion) do
    Request.get("/setting/accesslogs", QueryParams.convert(query_params, @all_params), client)
  end

  def get(id, query_params \\ [], client \\ HTTPotion) do
    Request.get("/setting/accesslogs/#{id}", QueryParams.convert(query_params, @get_params), client)
  end

end
