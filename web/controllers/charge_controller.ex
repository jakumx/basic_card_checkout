defmodule PhoenixCharges.ChargeController do
  use PhoenixCharges.Web, :controller

  alias PhoenixCharges.Charge
  alias PhoenixCharges.Card

  def create(conn, %{"charge" => charge_params}) do

    unless is_nil(charge_params["token"]) do

      card_result = Card
        |> Card.find_by_token(charge_params["token"])
        |> Repo.all

      if length(card_result) > 0 do
        card_result = hd(card_result)

        created = card_result.inserted_at
          |> Ecto.DateTime.to_erl
          |> Calendar.NaiveDateTime.add!(600)# add 10 min

        is_valid_token = Ecto.DateTime.utc()
          |> Ecto.DateTime.to_erl
          |> Calendar.NaiveDateTime.before?(created)

        if is_valid_token do
          charge_params = Map.put(charge_params, "card_id", card_result.id)

          changeset = Charge.changeset(%Charge{}, charge_params)

          case Repo.insert(changeset) do
            {:ok, charge} ->
              json conn, %{id: charge.id,
                product_name: charge.product_name,
                amount: charge.amount,
                card: %{
                  name: card_result.name,
                  number: card_result.number,
                  month: card_result.month,
                  year: card_result.year,
                  cvv: card_result.cvv,
                  address: card_result.address,
                  email: card_result.email
                }
              }
            {:error, changeset} ->
              conn
              |> put_status(:unprocessable_entity)
              |> render(PhoenixCharges.ChangesetView, "error.json", changeset: changeset)
          end

        else
          json conn, %{errors: %{message: "token expired"}}
        end

      else
        json conn, %{errors: %{message: "No token exist"}}
      end
      
    else
      json conn, %{errors: %{token: "can't be blank"}}
    end

  end

  def show(conn, %{"id" => id}) do
    charge = Repo.get!(Charge, id)
     |> Repo.preload([:card])
    render(conn, "show.json", charge: charge)
  end


end
