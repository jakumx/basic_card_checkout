defmodule PhoenixCharges.Charge do
  use PhoenixCharges.Web, :model

  schema "charges" do
    field :product_name, :string
    field :amount, :integer
    belongs_to :card, PhoenixCharges.Card

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:product_name, :amount, :card_id])
    |> validate_required([:product_name, :amount])
  end
end
