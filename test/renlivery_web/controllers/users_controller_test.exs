defmodule RenliveryWeb.UsersControllerTest do
  use RenliveryWeb.ConnCase, async: true

  import RenliveryWeb.Router.Helpers
  import Renlivery.Factory

  describe "create/2" do
    test "quando todos os parametros são validos, retorna um user", %{conn: conn} do
      params = build(:user_body)

      response =
        conn
        |> post(users_path(conn, :create), params)
        |> json_response(201)

      assert %{
               "data" => %{"cpf" => "12345678900", "id" => _id},
               "message" => "User created successfully"
             } = response
    end
  end
end
 