defmodule Shortener.Shorts do
  @moduledoc """
  The Shorts context.
  """

  import Ecto.Query, warn: false
  alias Shortener.Repo

  alias Shortener.Shorts.Short

  @doc """
  Returns the list of shorts.

  ## Examples

      iex> list_shorts()
      [%Short{}, ...]

  """
  def list_shorts do
    Repo.all(Short)
  end

  def shorts_csv do
    Repo.all(Short)
    |> Enum.map(fn short -> Map.take(short, [:short_code, :original, :visited]) end)
    |> CSV.encode(headers: true)
    |> Enum.to_list
    |> to_string
  end

  @doc """
  Gets a single short.

  Raises `Ecto.NoResultsError` if the Short does not exist.

  ## Examples

      iex> get_short!(123)
      %Short{}

      iex> get_short!(456)
      ** (Ecto.NoResultsError)

  """
  def get_short!(id), do: Repo.get!(Short, id)

  @doc """
  Creates a short.

  ## Examples

      iex> create_short(%{field: value})
      {:ok, %Short{}}

      iex> create_short(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_short(attrs \\ %{}) do
    attrs = create_shortened(attrs)
    %Short{}
    |> Short.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking short changes.

  ## Examples

      iex> change_short(short)
      %Ecto.Changeset{data: %Short{}}

  """
  def change_short(%Short{} = short, attrs \\ %{}) do
    Short.changeset(short, attrs)
  end

  def increment_visited(%Short{} = short) do
    change_short(short, %{visited: short.visited + 1})
    |> Repo.update!()
  end

  def get_by_short_code!(short_code) do
    Repo.get_by!(Short, short_code: short_code)
  end

  defp create_shortened(attrs) do
    original = attrs[:original] || attrs["original"]
    short_code = :crypto.strong_rand_bytes(4)
                |> Base.url_encode64(case: :lower, padding: false)
    %{original: original, short_code: short_code, visited: 0} 
  end
end
