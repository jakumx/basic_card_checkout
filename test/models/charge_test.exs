defmodule PhoenixCharges.ChargeTest do
  use PhoenixCharges.ModelCase

  alias PhoenixCharges.Charge

  @valid_attrs %{amount: 42, product_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Charge.changeset(%Charge{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Charge.changeset(%Charge{}, @invalid_attrs)
    refute changeset.valid?
  end
end
