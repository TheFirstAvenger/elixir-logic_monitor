require Logger

defmodule LogicMonitor.Request do
  @moduledoc """
  Provides the base request function and helper functions for GET and POST.
  Requests are authenticated using LMv1 Authentication as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/overview/using-logicmonitors-rest-api/#API-Token-Authentication).
  All request functions return either {:ok, {status, data}} or {:error, reason}
  """

  @type request_response :: {:ok, {any, any}} | {:error, any}

  @spec lm_account() :: String.t
  defp lm_account(), do: Application.get_env(:logic_monitor, :account)
  @spec lm_access_id() :: String.t
  defp lm_access_id(), do: Application.get_env(:logic_monitor, :access_id)
  @spec lm_access_key() :: String.t
  defp lm_access_key(), do: Application.get_env(:logic_monitor, :access_key)
  @spec lm_timeout() :: String.t
  defp lm_timeout(), do: Application.get_env(:logic_monitor, :timeout) || 30_000
  @spec lm_client() :: atom
  defp lm_client(), do: Application.get_env(:logic_monitor, :http_client) || HTTPotion

  @doc """
  Sends a GET request to the specified resource_path with the specified query_params.
  Sends multiple requests if negative total is returned (indicating more resources available)
  """
  @spec get(String.t, String.t) :: request_response
  def get(resource_path, query_params) do
    request("GET", resource_path, query_params, "")
    |> get_more([], resource_path, query_params)
  end

  #total is negative if there are more to return
  defp get_more({:error, reason}, _, _, _), do: {:error, reason}
  defp get_more({:ok, {200, %{"total" => total, "items" => items}}}, prev_items, _, _) when total >= 0 and ((length(prev_items) + length(items)) >= total), do: {:ok, {200, prev_items ++ items}}
  defp get_more({:ok, {200, %{"items" => items, "searchId" => search_id}}}, prev_items, resource_path, query_params) do
    request("GET", resource_path, "searchId=#{search_id}&offset=#{length(prev_items) + length(items)}&#{query_params}&size=300", "")
    |> get_more(prev_items ++ items, resource_path, query_params)
  end

  @doc """
  Sends a POST request to the specified resource_path with the specified
  query_params (as a string in the form "key1=val1&key2=val2") and the
  specified payload.
  """
  @spec post(String.t, String.t, String.t) :: request_response
  def post(resource_path, query_params, payload) do
    request("POST", resource_path, query_params, payload)
  end


  @doc """
  Sends a request using the specified method to the specified resource_path
  with the specified query_params (as a string in the form "key1=val1&key2=val2")
  and the specified payload.
  """
  @spec request(String.t, String.t, String.t, String.t) :: request_response
  def request(method, resource_path, query_params, payload) do
    url = "https://#{lm_account()}.logicmonitor.com/santaba/rest#{resource_path}?#{query_params}"
    auth = get_auth(method, resource_path)
    Logger.debug("LogicMonitor.Request: Sending #{method} to #{url} using #{lm_client()}")
    case httpotion_request(lm_client(), method, url, payload, [timeout: lm_timeout(), headers: ["Content-Type": "application/json", "Authorization": auth]]) do
      %HTTPotion.ErrorResponse{message: message} ->
        {:error, message}
      %HTTPotion.Response{body: body, headers: headers} ->
        case Poison.decode(body) do
           {:ok, %{"status" => status, "data" => data}} -> {:ok, {status, data}}
           {:error, {:invalid, "<", _}} -> {:error, {body, headers}}
           {:error, reason} -> {:error, reason}
        end
    end
  end

  def get_auth(method, resource_path) do
    timestamp_source = Application.get_env(:logic_monitor, :timestamp_override) || System
    epoch = timestamp_source.system_time(:millisecond)
    request_vars = "#{method}#{epoch}#{resource_path}"
    signature = :crypto.hmac(:sha256, lm_access_key(), request_vars) |> Base.encode16 |> to_string |> String.downcase |> Base.encode64
    "LMv1 #{lm_access_id()}:#{signature}:#{epoch}"
  end

  @spec httpotion_request(atom, String.t, String.t, String.t, list) :: %HTTPotion.ErrorResponse{} | %HTTPotion.Response{}
  defp httpotion_request(client, "GET", url, _payload, opts), do: client.get(url, opts)
  defp httpotion_request(client, "POST", url, payload, opts), do: client.post(url, [body: payload] ++ opts)
end
