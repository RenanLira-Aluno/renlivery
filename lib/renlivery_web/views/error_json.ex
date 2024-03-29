defmodule RenliveryWeb.ErrorJSON do
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render("error.json", %{result: %Changeset{} = changeset}) do
    %{errors: translate_error(changeset)}
  end

  def render("error.json", %{result: result}) do
    %{errors: result}
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  # codigo pego da documentação do phoenix
  defp translate_error(%Changeset{} = changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
