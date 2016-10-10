defmodule PhoenixCharges.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :number, :string
      add :month, :string
      add :year, :integer
      add :cvv, :integer
      add :address, :string
      add :email, :string
      add :token_id, :string
      add :tokenCreated, :datetime

      timestamps()
    end

  end
end
