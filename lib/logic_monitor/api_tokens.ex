defmodule LogicMonitor.ApiTokens do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @all_params [:sort, :filter, :fields, :size, :offset]
  @for_user_params []

  def all(query_params \\ [], client \\ HTTPotion) do
    Request.get("/setting/admins/apitokens", QueryParams.convert(query_params, @all_params), client)
  end

  def for_user(user_id, query_params \\ [], client \\ HTTPotion) do
    Request.get("/setting/admins/#{user_id}/apitokens", QueryParams.convert(query_params, @for_user_params), client)
  end

end
