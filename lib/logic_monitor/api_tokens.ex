defmodule LogicMonitor.ApiTokens do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @moduledoc """
  Provides access to the API Tokens Resource
  """

  @all_params [:sort, :filter, :fields, :size, :offset]

  @doc """
  Returns all Api Tokens. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/api-tokens/get-api-tokens/).
  """
  @spec all([{atom, String.t}]) :: Request.request_response
  def all(query_params \\ []) do
    Request.get("/setting/admins/apitokens", QueryParams.convert(query_params, @all_params))
  end

  @doc """
  Returns all Api Tokens for the specified user.
  """
  @spec for_user(String.t) :: Request.request_response
  def for_user(user_id) do
    Request.get("/setting/admins/#{user_id}/apitokens", "")
  end

end
