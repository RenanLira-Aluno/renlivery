defmodule Renlivery.UserTest do
  alias Ecto.Changeset
  alias Renlivery.User
  use Renlivery.DataCase, async: true

  import Renlivery.Factory

  describe "changeset/2" do
    setup %{} do
      params = build(:user_params)

      %{params: params}
    end

    test "todos os parametros validos, retorna um changeset com sucesso", %{params: params} do
      response = User.changeset(params)

      assert %Changeset{changes: %{name: "John Doe"}, valid?: true} = response
    end

    test "atualizando um changeset, retorna um changeset valido", %{params: params} do
      response =
        params
        |> User.changeset()
        |> User.changeset(%{name: "Renan"})

      assert %Changeset{changes: %{name: "Renan"}, valid?: true} = response
    end

    test "parametros invalidados, retorna um changeset invalido", %{params: params} do
      new_params = %{params | age: 16}

      response = User.changeset(new_params)

      assert errors_on(response) == %{age: ["must be greater than or equal to 18"]}
    end
  end
end
