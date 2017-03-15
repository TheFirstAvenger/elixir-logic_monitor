defmodule LogicMonitor.Request do
  def lm_account(), do: Application.get_env(:logic_monitor, :account)
  def lm_access_id(), do: Application.get_env(:logic_monitor, :access_id)
  def lm_access_key(), do: Application.get_env(:logic_monitor, :access_key)

  def get(resource_path, query_params, client \\ HTTPotion) do
    request("GET", resource_path, query_params, '')
  end

  def post(resource_path, query_params, payload, client \\ HTTPotion) do
    request("POST", resource_path, query_params, payload)
  end

  def request(method, resource_path, query_params, payload, client \\ HTTPotion) do
    url = "https://#{lm_account()}.logicmonitor.com/santaba/rest#{resource_path}?#{query_params}"
    epoch = :os.system_time(:millisecond)
    request_vars = "#{method}#{epoch}#{resource_path}"
    signature = :crypto.hmac(:sha256, lm_access_key(), request_vars) |> Base.encode16 |> to_string |> String.downcase |> Base.encode64
    auth = "LMv1 #{lm_access_id()}:#{signature}:#{epoch}"

    case httpotion_request(client, method, url, payload, [timeout: 30_000, headers: ["Content-Type": "application/json", "Authorization": auth]]) do
      {%HTTPotion.ErrorResponse{message: message}} ->
        {:error, message}
      %{body: body, headers: headers} ->
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
