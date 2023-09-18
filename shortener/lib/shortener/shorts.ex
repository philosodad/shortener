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
  Updates a short.

  ## Examples

      iex> update_short(short, %{field: new_value})
      {:ok, %Short{}}

      iex> update_short(short, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_short(%Short{} = short, attrs) do
    short
    |> Short.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a short.

  ## Examples

      iex> delete_short(short)
      {:ok, %Short{}}

      iex> delete_short(short)
      {:error, %Ecto.Changeset{}}

  """
  def delete_short(%Short{} = short) do
    Repo.delete(short)
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

  defp create_shortened(attrs) do
    original = attrs[:original] || attrs["original"]
    shortened = :crypto.strong_rand_bytes(4)
                |> Base.url_encode64(case: :lower, padding: false)
                  %{original: original, shortened: "#{ShortenerWeb.Endpoint.url()}/#{shortened}", visited: 0} 
  end
end
