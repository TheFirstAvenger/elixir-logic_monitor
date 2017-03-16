defmodule LogicMonitor.Alerts do
  alias LogicMonitor.Request
  alias LogicMonitor.QueryParams

  @all_params [:sort, :filter, :fields, :size, :offset, :searchId, :needMessage, :customColumns]

  def all(query_params \\ [], client \\ HTTPotion) do
    Request.get("/alert/alerts", QueryParams.to_string(query_params, @all_params), client)
  end

  # def ack(id, ack_comment, client \\ HTTPotion) do
  #   Request.post("/alert/alerts/#{id}/ack", "", "{\"ackComment\":\"#{ack_comment}\"}", client)
  # end

end
