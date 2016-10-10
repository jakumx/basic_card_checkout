defmodule PhoenixCharges.CardController do
  use PhoenixCharges.Web, :controller

  alias PhoenixCharges.Card

  def create(conn, %{"card" => card_params}) do

    expire_is_after = {card_params["year"], String.to_integer(card_params["month"]) ,1}
      |> Calendar.Date.from_erl!
      |> Calendar.Date.after?(Calendar.DateTime.now_utc)

    unless expire_is_after do
      json conn, %{errors: %{message: "expire date"}}
    else

      all_params = card_params["name"] <> card_params["number"] <> card_params["month"] <> Integer.to_string(card_params["year"]) <> Integer.to_string(card_params["cvv"])

      token_created = Calendar.DateTime.now_utc
       |> Calendar.DateTime.Format.rfc3339 
      token_id =  Comeonin.Bcrypt.hashpwsalt(all_params)
      card_params = Map.put_new(card_params, "token_id", token_id)
      card_params = Map.put_new(card_params, "tokenCreated", token_created)

      changeset = Card.changeset(%Card{}, card_params)

      case Repo.insert(changeset) do
        {:ok, card} ->
          json conn, %{ok: true, token: token_id}
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(PhoenixCharges.ChangesetView, "error.json", changeset: changeset)
      end
    end

  end 

end
