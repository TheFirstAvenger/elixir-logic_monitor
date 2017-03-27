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
    Request.get_all("/setting/admins/apitokens", QueryParams.convert(query_params, @all_params))
  end

  @doc """
  Same as `all/1` but raises error if it fails
  """
  @spec all!([{atom, String.t}]) :: [any]
  def all!(query_params \\ []) do
    case all(query_params) do
      {:ok, {200, items}} -> items
      {:error, reason} -> raise "Error in #{__MODULE__}.all!: #{inspect reason}"
    end
  end

  @doc """
  Returns all Api Tokens for the specified user.
  """
  @spec for_user(String.t) :: Request.request_response
  def for_user(user_id) do
    Request.get_all("/setting/admins/#{user_id}/apitokens", "")
  end

  @doc """
  Same as `for_user/1` but raises error if it fails
  """
  @spec for_user!(String.t) :: [any]
  def for_user!(user_id) do
    case for_user(user_id) do
      {:ok, {200, items}} -> items
      {:error, reason} -> raise "Error in #{__MODULE__}.for_user!: #{inspect reason}"
    end
  end

end
