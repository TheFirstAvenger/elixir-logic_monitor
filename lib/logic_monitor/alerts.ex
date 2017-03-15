defmodule LogicMonitor.Alerts do
  alias LogicMonitor.Request

  def get(query_params \\ "", client \\ HTTPotion) do
    Request.get("/alert/alerts", query_params, client)
  end

  def ack(id, ack_comment, client \\ HTTPotion) do
    Request.post("/alert/alerts/#{id}/ack", "", "{\"ackComment\":\"#{ack_comment}\"}", client)
  end

end
