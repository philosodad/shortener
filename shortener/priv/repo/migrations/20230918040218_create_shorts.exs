defmodule Shortener.Repo.Migrations.CreateShorts do
  use Ecto.Migration

  def change do
    create table(:shorts) do
      add :shortened, :string
      add :original, :string
      add :visited, :integer, default: 0

      timestamps()
    end
  end
end
