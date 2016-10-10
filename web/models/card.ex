defmodule PhoenixCharges.Card do
  use PhoenixCharges.Web, :model

  schema "cards" do
    field :name, :string
    field :number, :string
    field :month, :string
    field :year, :integer
    field :cvv, :integer
    field :address, :string
    field :email, :string
    field :token_id, :string
    field :tokenCreated, Ecto.DateTime

    has_one :charge, PhoenixCharges.Charge

    timestamps()
  end

  def find_by_token(query, token) do
    from q in query,
    where: q.token_id == ^token
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :number, :month, :year, :cvv, :address, :email, :token_id, :tokenCreated])
    |> validate_required([:name, :number, :month, :year, :cvv, :address, :email, :token_id, :tokenCreated])
    |> validate_length(:number, min: 16)
    |> validate_length(:number, max: 16)
    |> validate_length(:month, min: 2)
    |> validate_length(:month, max: 2)
    |> validate_number(:year, greater_than: 2015)# this year - 1
    |> validate_format(:email, ~r/@/)
  end
end
