defmodule Shortener.ShortsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortener.Shorts` context.
  """

  @doc """
  Generate a short.
  """
  def short_fixture(attrs \\ %{}) do
    {:ok, short} =
      attrs
      |> Enum.into(%{
        visited: 42,
        short_code: :crypto.strong_rand_bytes(4)
        |> Base.url_encode64(case: :lower, padding: false),
        original: Faker.Internet.url()
      })
      |> Shortener.Shorts.create_short()

    short
  end
end
