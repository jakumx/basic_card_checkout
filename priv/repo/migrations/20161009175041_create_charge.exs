defmodule PhoenixCharges.Repo.Migrations.CreateCharge do
  use Ecto.Migration

  def change do
    create table(:charges) do
      add :product_name, :string
      add :amount, :integer
      add :card_id, references(:cards, on_delete: :nothing)

      timestamps()
    end
    create index(:charges, [:card_id])

  end
end
