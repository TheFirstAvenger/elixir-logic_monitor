# LogicMonitor

Elixir wrapper for the Logic Monitor REST API as outlined [here](https://www.logicmonitor.com/support/rest-api-developers-guide/).

Still in development. POST has not been tested. Need remainder of resources implemented. Contributions welcome!

## Installation

LogicMonitor can be installed by adding `logic_monitor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:logic_monitor, "~> 0.0.9"}]
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
config :logic_monitor,
  timeout: 60_000
```
## Usage

For each Resource, the list of allowable query parameters can be found on the LogicMonitor site [here](https://www.logicmonitor.com/support/rest-api-developers-guide/overview/) or in a module resource at the top of the respective module.
### Alerts
```elixir
{:ok, {200, alerts}} = LogicMonitor.Alerts.all()
{:ok, {200, alerts}} = LogicMonitor.Alerts.all(sort: "this_way", fields: "type,id")
alerts = LogicMonitor.Alerts.all!()
alerts = LogicMonitor.Alerts.all!(sort: "this_way", fields: "type,id")
```

### ApiTokens
```elixir
{:ok, {200, tokens}} = LogicMonitor.ApiTokens.all()
{:ok, {200, tokens}} = LogicMonitor.ApiTokens.all(sort: "this_way", fields: "accessId,adminName")
{:ok, {200, tokens}} = LogicMonitor.ApiTokens.for_user("124")
tokens = LogicMonitor.ApiTokens.all!()
tokens = LogicMonitor.ApiTokens.all!(sort: "this_way", fields: "accessId,adminName")
tokens = LogicMonitor.ApiTokens.for_user!("124")
```

### AuditLogs
```elixir
{:ok, {200, logs}} = LogicMonitor.AuditLogs.all()
{:ok, {200, logs}} = LogicMonitor.AuditLogs.all(sort: "this_way", fields: "a,b,c")
{:ok, {200, logs}} = LogicMonitor.AuditLogs.get("12345")
{:ok, {200, logs}} = LogicMonitor.AuditLogs.get("12345", fields: "a,b,c")
logs = LogicMonitor.AuditLogs.all!()
logs = LogicMonitor.AuditLogs.all!(sort: "this_way", fields: "a,b,c")
logs = LogicMonitor.AuditLogs.get!("12345")
logs = LogicMonitor.AuditLogs.get!("12345", fields: "a,b,c")
```

### Devices
```elixir
{:ok, {200, devices}} = LogicMonitor.Devices.all()
{:ok, {200, devices}} = LogicMonitor.Devices.all(sort: "this_way", fields: "a,b,c")
{:ok, {200, devices}} = LogicMonitor.Devices.get("12345")
{:ok, {200, devices}} = LogicMonitor.Devices.get("12345", fields: "a,b,c")
devices = LogicMonitor.Devices.all!()
devices = LogicMonitor.Devices.all!(sort: "this_way", fields: "a,b,c")
devices = LogicMonitor.Devices.get!("12345")
devices = LogicMonitor.Devices.get!("12345", fields: "a,b,c")
```

Raw requests to Logic Monitor for resources that are not yet implemented can be made like this:

```elixir
{:ok, {200, alerts}} = LogicMonitor.Request.get("/alert/alerts","filter=type:serviceAlert")
{:ok, {status, alerts}} = LogicMonitor.Request.post("/alert/alerts/1234/ack", "", "{\"ackComment\":\"hello\"}")
```

Docs can be found at [https://hexdocs.pm/logic_monitor](https://hexdocs.pm/logic_monitor).
