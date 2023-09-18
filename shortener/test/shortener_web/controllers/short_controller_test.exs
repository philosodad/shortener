defmodule ShortenerWeb.ShortControllerTest do
  use ShortenerWeb.ConnCase

  @create_attrs %{visited: nil, shortened: nil, original: "http://some.original"}
  @invalid_attrs %{visited: nil, shortened: nil, original: nil}

  describe "stats" do
    test "lists all shorts", %{conn: conn} do
      conn = get(conn, ~p"/stats")
      assert html_response(conn, 200) =~ "Shortened URLs"
    end
  end

  describe "new short url form" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "URL To Shorten"
    end
  end

  describe "getting a shortened url" do
    test "redirects to the original", %{conn: conn} do
      %{id: id} = 
        post(conn, ~p"/shorts", short: @create_attrs)
        |> redirected_params()
      %{original: original_url, shortened: short_url} = Shortener.Shorts.get_short!(id)
      conn = get(conn, short_url)
      assert redirected_to(conn) == original_url
    end
     
  end

  describe "create short" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/shorts", short: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/shorts/#{id}"

      conn = get(conn, ~p"/shorts/#{id}")
      %{shortened: short_url} = Shortener.Shorts.get_short!(id)
      assert html_response(conn, 200) =~ "#{short_url}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/shorts", short: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Short"
    end
  end

end
