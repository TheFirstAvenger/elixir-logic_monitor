use Mix.Config

config :logic_monitor,
  account: "test",
  access_key: "test",
  access_id: "test",
  timestamp_override: LogicMonitor.MockTimestamp,
  http_client: LogicMonitor.MockClient

config :logger,
  level: :warn
