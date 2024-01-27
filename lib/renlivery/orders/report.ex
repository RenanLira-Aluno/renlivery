defmodule Renlivery.Orders.Report do
  alias Renlivery.Item
  alias Renlivery.Order
  alias Renlivery.Repo

  import Ecto.Query

  @default_block_size 500

  @spec create(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: :ok | {:error, atom()}
  def create(filename \\ "report.csv") do
    query = from(o in Order, order_by: o.user_id)

    {:ok, orders_string} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream(max_rows: @default_block_size)
          |> Stream.chunk_every(@default_block_size)
          |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
          |> Enum.map(&parse_line/1)
        end,
        timeout: :infinity
      )

    File.write(filename, orders_string)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment, items: items}) do
    items_string =
      Task.async(fn ->
        Enum.map(items, &item_string/1) |> Enum.join(";")
      end)

    total_price =
      Task.async(fn ->
        Enum.reduce(items, Decimal.new("0.00"), &Decimal.add(&1.price, &2))
      end)

    [items_string, total_price] = Task.await_many([items_string, total_price], 10_000)

    "#{user_id},#{payment},[#{items_string}],#{total_price}\n"
  end

  defp item_string(%Item{description: description, price: price, category: category}) do
    "#{category},#{description},#{price}"
  end
end
