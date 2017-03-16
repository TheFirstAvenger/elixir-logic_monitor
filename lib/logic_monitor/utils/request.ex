defmodule LogicMonitor.Request do
  def lm_account(), do: Application.get_env(:logic_monitor, :account)
  def lm_access_id(), do: Application.get_env(:logic_monitor, :access_id)
  def lm_access_key(), do: Application.get_env(:logic_monitor, :access_key)
  def lm_timeout(), do: Application.get_env(:logic_monitor, :timeout) || 30_000

  def get(resource_path, query_params, client \\ HTTPotion) do
    request("GET", resource_path, query_params, '', client)
  end

  def post(resource_path, query_params, payload, client \\ HTTPotion) do
    request("POST", resource_path, query_params, payload, client)
  end

  def request(method, resource_path, query_params, payload, client \\ HTTPotion) do
    url = "https://#{lm_account()}.logicmonitor.com/santaba/rest#{resource_path}?#{query_params}"
    timestamp_source = Application.get_env(:logic_monitor, :timestamp_override) || :os
    epoch = timestamp_source.system_time(:millisecond)
    request_vars = "#{method}#{epoch}#{resource_path}"
    signature = :crypto.hmac(:sha256, lm_access_key(), request_vars) |> Base.encode16 |> to_string |> String.downcase |> Base.encode64
    auth = "LMv1 #{lm_access_id()}:#{signature}:#{epoch}"
    IO.inspect url
    case httpotion_request(client, method, url, payload, [timeout: lm_timeout(), headers: ["Content-Type": "application/json", "Authorization": auth]]) do
      %HTTPotion.ErrorResponse{message: message} ->
        {:error, message}
      ret = %{body: body, headers: headers} ->
        IO.inspect ret
        case Poison.decode(body) do
           {:ok, %{"status" => status, "data" => data}} -> {:ok, {status, data}}
           {:error, {:invalid, "<", _}} -> {:error, {body, headers}}
           {:error, reason} -> {:error, reason}
        end
    end
  end

  def httpotion_request(client, "GET", url, _payload, opts), do: client.get(url, opts)
  def httpotion_request(client, "POST", url, payload, opts), do: client.post(url, [body: payload] ++ opts)
end
