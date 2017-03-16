use Mix.Config

config :logic_monitor,
  account: System.get_env("LM_ACCOUNT"),
  access_id: System.get_env("LM_ACCESS_ID"),
  access_key: System.get_env("LM_ACCESS_KEY")

config :logger,
  level: :warn
