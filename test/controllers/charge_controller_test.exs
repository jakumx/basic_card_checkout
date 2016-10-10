defmodule PhoenixCharges.ChargeControllerTest do
  use PhoenixCharges.ConnCase

  alias PhoenixCharges.Charge
  @valid_attrs %{amount: 42, product_name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, charge_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    charge = Repo.insert! %Charge{}
    conn = get conn, charge_path(conn, :show, charge)
    assert json_response(conn, 200)["data"] == %{"id" => charge.id,
      "product_name" => charge.product_name,
      "amount" => charge.amount,
      "card_id" => charge.card_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, charge_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, charge_path(conn, :create), charge: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Charge, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, charge_path(conn, :create), charge: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    charge = Repo.insert! %Charge{}
    conn = put conn, charge_path(conn, :update, charge), charge: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Charge, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    charge = Repo.insert! %Charge{}
    conn = put conn, charge_path(conn, :update, charge), charge: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    charge = Repo.insert! %Charge{}
    conn = delete conn, charge_path(conn, :delete, charge)
    assert response(conn, 204)
    refute Repo.get(Charge, charge.id)
  end
end
