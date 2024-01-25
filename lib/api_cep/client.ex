defmodule Renlivery.ApiCep.Client do
  alias Renlivery.Error
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://brasilapi.com.br/api/cep/v1/"
  plug Tesla.Middleware.JSON

  def get_cep(cep) do
    "#{cep}"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %Tesla.Env{status: 404}}),
    do: {:error, Error.build(:not_found, "CEP not found")}

  defp handle_response({:error, _}),
    do: {:error, Error.build(:api_error, "Error on request")}
end
