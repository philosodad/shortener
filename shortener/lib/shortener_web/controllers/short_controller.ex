defmodule ShortenerWeb.ShortController do
  use ShortenerWeb, :controller

  alias Shortener.Shorts
  alias Shortener.Shorts.Short

  def index(conn, _params) do
    shorts = Shorts.list_shorts()
    render(conn, :index, shorts: shorts)
  end

  def new(conn, _params) do
    changeset = Shorts.change_short(%Short{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"short" => short_params}) do
    case Shorts.create_short(short_params) do
      {:ok, short} ->
        conn
        |> put_flash(:info, "Short created successfully.")
        |> redirect(to: ~p"/shorts/#{short}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    short = Shorts.get_short!(id)
    render(conn, :show, short: short)
  end

end
