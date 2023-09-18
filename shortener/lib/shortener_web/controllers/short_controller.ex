defmodule ShortenerWeb.ShortController do
  use ShortenerWeb, :controller
  alias Shortener.Shorts
  alias Shortener.Shorts.Short
  alias CSV

  def index(conn, _params) do
    shorts = Shorts.list_shorts()
    render(conn, :index, shorts: shorts)
  end

  def download(conn, _params) do
    shorts = Shorts.list_shorts()
             |> Enum.map(fn short -> Map.take(short, [:short_code, :original, :visited]) end)
             |> CSV.encode(headers: true) 
             |> Enum.to_list
             |> to_string
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"shortened_urls.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, shorts)
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

  def original(conn, %{"short_code" => short_code}) do
    %{original: original} = Shorts.get_by_short_code!(short_code)
    redirect(conn, external: original)
  end

  def show(conn, %{"id" => id}) do
    short = Shorts.get_short!(id)
    render(conn, :show, short: short)
  end

end
