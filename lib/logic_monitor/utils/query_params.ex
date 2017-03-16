defmodule LogicMonitor.QueryParams do

  @doc """
  Converts a keyword list and a list of atoms into a querystring containing only
  entries that exist in both the keyword list and the list of atoms.

  ## Examples

      iex> LogicMonitor.QueryParams.to_string([asdf: 123, hjkl: 456], [:asdf, :hjkl])
      "asdf=123&hjkl=456"

      iex> LogicMonitor.QueryParams.to_string([asdf: 123, hjkl: 456], [:asdf])
      "asdf=123"

      iex> LogicMonitor.QueryParams.to_string([asdf: 123, hjkl: 456], [:hjkl])
      "hjkl=456"

      iex> LogicMonitor.QueryParams.to_string([asdf: 123, hjkl: 456], [:qwerty])
      ""

      iex> LogicMonitor.QueryParams.to_string([asdf: 123, hjkl: 456], [])
      ""

  """
  def to_string(_params, []), do: ""
  def to_string(params, [h | t]) do
    amp = case t do
      [] -> ""
      _  -> "&"
    end
    cond do
      Keyword.has_key?(params, h) -> "#{to_string(h)}=#{params[h]}#{amp}#{to_string(params, t)}"
      true -> to_string(params, t)
    end
  end

end
