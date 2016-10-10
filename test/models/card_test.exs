defmodule PhoenixCharges.CardTest do
  use PhoenixCharges.ModelCase

  alias PhoenixCharges.Card

  @valid_attrs %{address: "some content", cvv: 42, email: "some content", month: "some content", name: "some content", number: "some content", tokenCreated: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, token_id: "some content", year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
