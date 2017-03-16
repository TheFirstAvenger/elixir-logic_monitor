# LogicMonitor

Elixir wrapper for the Logic Monitor REST API as outlined [here](https://www.logicmonitor.com/support/rest-api-developers-guide/).

Still in development. POST has not been tested. Need remainder of resources implemented. Contributions welcome!

## Installation

LogicMonitor can be installed by adding `logic_monitor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:logic_monitor, "~> 0.0.2"}]
end
```

## Configuration

LogicMonitor requires three application variables. Add the following variables to your config.exs file (this example retrieves those variables from environment variables):

```elixir
config :logic_monitor,
  account: System.get_env("LM_ACCOUNT"),
  access_id: System.get_env("LM_ACCESS_ID"),
  access_key: System.get_env("LM_ACCESS_KEY")
```

The HTTPotion timeout value is configurable by the optional `timeout` application variable, which defaults to 30_000 (30 seconds) when not set:

```elixir
config: :logic_monitor,
  timeout: 60_000

## Usage

Raw requests to Logic Monitor for resources that are not yet implemented can be made like this:

```
LogicMonitor.Request.get("/alert/alerts","filter=type:serviceAlert")
LogicMonitor.Request.post("/alert/alerts/1234/ack", "", "{\"ackComment\":\"hello\"}")
```

Currently implemented resources:

* Alerts
  * all(query_params)
* ApiTokens
  * all(query_params)
* AuditLogs
  * all(query_params)
  * get(id, query_params)

You will notice the optional `client \\ HTTPotion` is the final parameter for all requests. This is to facilitate passing mock clients into test cases.


Docs can be found at [https://hexdocs.pm/logic_monitor](https://hexdocs.pm/logic_monitor).
