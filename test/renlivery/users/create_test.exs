defmodule Renlivery.Users.CreateTest do
  use Renlivery.DataCase, async: true

  alias Renlivery.Users.Create
  alias Renlivery.{Error, User}

  import Renlivery.Factory

  describe "call/1" do
    setup %{} do
      params = build(:user_params)

      %{params: params}
    end

    test "todos os parametros validos, retorna um user criado", %{params: params} do
      response = Create.call(params)
      assert {:ok, %User{id: _id}} = response
    end

    test "parametros invalidos, retorna um erro", %{params: params} do
      new_params = %{params | age: 16}

      response = Create.call(new_params)

      assert {:error, %Error{status: :bad_request}} = response
    end
  end
end
