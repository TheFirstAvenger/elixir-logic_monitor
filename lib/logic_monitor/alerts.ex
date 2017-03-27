defmodule LogicMonitor.Alerts do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @moduledoc """
  Provides access to the Alerts resource.
  """

  @all_params [:sort, :filter, :fields, :size, :offset, :searchId, :needMessage, :customColumns]

  @doc """
  Returns all alerts. Request parameters as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/alerts/get-alerts/).
  """
  @spec all([{atom, String.t}]) :: Request.request_response
  def all(query_params \\ []) do
    Request.get_all("/alert/alerts", QueryParams.convert(query_params, @all_params))
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

  # def ack(id, ack_comment) do
  #   Request.post("/alert/alerts/#{id}/ack", "", "{\"ackComment\":\"#{ack_comment}\"}")
  # end

end
