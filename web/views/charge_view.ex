defmodule PhoenixCharges.ChargeView do
  use PhoenixCharges.Web, :view

  def render("index.json", %{charges: charges}) do
    %{data: render_many(charges, PhoenixCharges.ChargeView, "charge.json")}
  end

  def render("show.json", %{charge: charge}) do
    %{data: render_one(charge, PhoenixCharges.ChargeView, "charge.json")}
  end

  def render("charge.json", %{charge: charge}) do
    %{id: charge.id,
      product_name: charge.product_name,
      amount: charge.amount,
      card: %{
        name: charge.card.name,
        number: charge.card.number,
        month: charge.card.month,
        year: charge.card.year,
        cvv: charge.card.cvv,
        address: charge.card.address,
        email: charge.card.email
      }
    }
  end
end
