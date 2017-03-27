defmodule LogicMonitor.Devices do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @moduledoc """
  Provides access to the Devices resource.
  """

  @all_params [:sort, :filter, :fields, :size, :offset]
  @get_params [:fields]

  @doc """
  Returns all Devices. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/alerts/get-devices/).
  """
  @spec all([{atom, String.t}]) :: Request.request_response
  def all(query_params \\ []) do
    Request.get_all("/device/devices", QueryParams.convert(query_params, @all_params))
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
  Returns the specified device. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/devices/get-devices/).
  """
  @spec get(String.t, [{atom, String.t}]) :: Request.request_response
  def get(id, query_params \\ []) do
    Request.get_one("/device/devices/#{id}", QueryParams.convert(query_params, @get_params))
  end

  @doc """
  Same as `get/1` but raises error if it fails
  """
  @spec get!(String.t, [{atom, String.t}]) :: any
  def get!(id, query_params \\ []) do
    case get(id, query_params) do
      {:ok, {200, item}} -> item
      {:error, reason} -> raise "Error in #{__MODULE__}.get!: #{inspect reason}"
    end
  end

end
