# LogicMonitor

Elixir wrapper for the Logic Monitor REST API as outlined [here](https://www.logicmonitor.com/support/rest-api-developers-guide/).

Still in development. Tests cases not yet written. POST has not been tested. Need remainder of resources implemented. Contributions welcome!

## Installation

LogicMonitor can be installed by adding `logic_monitor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:logic_monitor, "~> 0.0.1"}]
end
```

## Configuration

LogicMonitor requires three application variables. Add the following to your config.exs file to retrieve those variables from environment variables:

```elixir
config :logic_monitor,
  account: System.get_env("LM_ACCOUNT"),
  access_id: System.get_env("LM_ACCESS_ID"),
  access_key: System.get_env("LM_ACCESS_KEY")
```

## Usage

Raw requests to Logic Monitor for resources that are not yet implemented can be made like this:

```
LogicMonitor.Request.get("/alert/alerts","filter=type:serviceAlert")
LogicMonitor.Request.post("/alert/alerts/1234/ack", "", "{\"ackComment\":\"hello\"}")
```

Currently implemented resources:

* Alerts
  * get(query_params)
  * ack(id, comment)

You will notice the optional `client \\ HTTPotion` is the final parameter for all requests. This is to facilitate passing mock clients into (future) test cases.


Docs can be found at [https://hexdocs.pm/logic_monitor](https://hexdocs.pm/logic_monitor).
