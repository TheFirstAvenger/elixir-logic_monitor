defmodule LogicMonitor.ApiTokens do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @all_params [:sort, :filter, :fields, :size, :offset]

  def all(query_params \\ [], client \\ HTTPotion) do
    Request.get("/setting/admins/apitokens", QueryParams.convert(query_params, @all_params), client)
  end

end
