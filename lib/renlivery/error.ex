defmodule Renlivery.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{status: status, result: result}
  end

  def build_user_not_fount_error, do: build(:not_found, "User Not found")
  def build_id_invalid_error, do: build(:bad_request, "Invalid UUID")
end
