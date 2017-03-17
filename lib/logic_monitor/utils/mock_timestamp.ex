defmodule LogicMonitor.MockTimestamp do
  @moduledoc """
  Mock module to replace :os in testing. Provides a predictable timestamp to
  verify authorization hashing algorithm is functioning correctly.
  """
  @spec system_time(:millisecond) :: integer
  def system_time(:millisecond), do: 12345678
end
