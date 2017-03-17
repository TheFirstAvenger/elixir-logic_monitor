require Logger

defmodule LogicMonitor.Request do
  @moduledoc """
  Provides the base request function and helper functions for GET and POST.
  Requests are authenticated using LMv1 Authentication as described [here](https://www.logicmonitor.com/support/rest-api-developers-guide/overview/using-logicmonitors-rest-api/#API-Token-Authentication)
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
  Sends a GET request to the specified resource_path with the specified query_params
  Optional client value allows mocking of HTTPotion for testing purposes
  """
  @spec get(String.t, String.t) :: request_response
  def get(resource_path, query_params) do
    request("GET", resource_path, query_params, "")
  end

  @doc """
  Sends a POST request to the specified resource_path with the specified
  query_params (as a string in the form "key1=val1&key2=val2") and the
  specified payload.
  Optional client value allows mocking of HTTPotion for testing purposes
  """
  @spec post(String.t, String.t, String.t) :: request_response
  def post(resource_path, query_params, payload) do
    request("POST", resource_path, query_params, payload)
  end


  @doc """
  Sends a request using the specified method to the specified resource_path
  with the specified query_params (as a string in the form "key1=val1&key2=val2")
  and the specified payload.
  Optional client value allows mocking of HTTPotion for testing purposes
  """
  @spec request(String.t, String.t, String.t, String.t) :: request_response
  def request(method, resource_path, query_params, payload) do
    url = "https://#{lm_account()}.logicmonitor.com/santaba/rest#{resource_path}?#{query_params}"
    timestamp_source = Application.get_env(:logic_monitor, :timestamp_override) || :os
    epoch = timestamp_source.system_time(:millisecond)
    request_vars = "#{method}#{epoch}#{resource_path}"
    signature = :crypto.hmac(:sha256, lm_access_key(), request_vars) |> Base.encode16 |> to_string |> String.downcase |> Base.encode64
    auth = "LMv1 #{lm_access_id()}:#{signature}:#{epoch}"
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

  @spec httpotion_request(atom, String.t, String.t, String.t, list) :: %HTTPotion.ErrorResponse{} | %HTTPotion.Response{}
  defp httpotion_request(client, "GET", url, _payload, opts), do: client.get(url, opts)
  defp httpotion_request(client, "POST", url, payload, opts), do: client.post(url, [body: payload] ++ opts)
end
