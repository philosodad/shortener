defmodule Shortener.Repo.Migrations.ChangeShortenedToShortCode do
  use Ecto.Migration

  def change do
    rename table("shorts"), :shortened, to: :short_code
  end
end
