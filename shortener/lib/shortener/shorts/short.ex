defmodule Shortener.Shorts.Short do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shorts" do
    field :visited, :integer, default: 0
    field :shortened, :string
    field :original, :string

    timestamps()
  end

  @doc false
  def changeset(short, attrs) do
    short
    |> cast(attrs, [:shortened, :original, :visited])
    |> validate_required([:original])
    |> validate_format(:original, ~r/^https?:\/\/[[:^space:]]+\.[[:^space:]]+$/)
  end

end
