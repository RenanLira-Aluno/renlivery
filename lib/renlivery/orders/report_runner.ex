defmodule Renlivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Renlivery.Orders.Report

  def start_link(_init_args) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(init_arg) do
    schedule_report()
    {:ok, init_arg}
  end

  @impl true
  def handle_info(:generate_report, state) do
    Logger.info("Gerando relarório...")

    Report.create()
    schedule_report()

    {:noreply, state}
  end

  def schedule_report() do
    Process.send_after(self(), :generate_report, 60_000)
  end
end
