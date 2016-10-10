defmodule PhoenixCharges.CardView do
  use PhoenixCharges.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, PhoenixCharges.CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, PhoenixCharges.CardView, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{id: card.id,
      name: card.name,
      number: card.number,
      month: card.month,
      year: card.year,
      cvv: card.cvv,
      address: card.address,
      email: card.email,
      token_id: card.token_id,
      tokenCreated: card.tokenCreated}
  end
end
