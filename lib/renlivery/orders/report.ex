defmodule Renlivery.Orders.Report do
  alias Renlivery.Order
  alias Renlivery.Repo

  import Ecto.Query

  @default_block_size 500

  def create(filename \\ "report.csv") do
    query = from(o in Order, order_by: o.user_id)

    Repo.transaction(fn ->
      query
      |> Repo.stream(max_rows: @default_block_size)
      |> Stream.chunk_every(@default_block_size)
      |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
      |> Enum.into([])
      |> IO.inspect()
    end)
  end
end
