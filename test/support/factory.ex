defmodule Renlivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      name: "John Doe",
      age: 18,
      address: "Rua dos bobos",
      cep: "12345-678",
      cpf: "12345678900",
      password: "123456",
      email: "test@test.com"
    }
  end

  def user_body_factory do
    %{
      "name" => "John Doe",
      "age" => 18,
      "address" => "Rua dos bobos",
      "cep" => "12345-678",
      "cpf" => "12345678900",
      "password" => "123456",
      "email" => "renan@email.com"
    }
  end
end
