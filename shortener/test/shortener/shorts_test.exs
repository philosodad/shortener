defmodule Shortener.ShortsTest do
  use Shortener.DataCase

  alias Shortener.Shorts

  describe "shorts" do
    alias Shortener.Shorts.Short

    import Shortener.ShortsFixtures

    @invalid_attrs %{visited: nil, shortened: nil, original: nil}

    test "list_shorts/0 returns all shorts" do
      short = short_fixture()
      assert Shorts.list_shorts() == [short]
    end

    test "get_short!/1 returns the short with given id" do
      short = short_fixture()
      assert Shorts.get_short!(short.id) == short
    end

    test "get_by_short_code!/1 returns a short with a given short_code" do
      short = short_fixture()
      assert Shorts.get_by_short_code!(short.short_code).id == short.id
    end

    test "increment_visited" do
      short = short_fixture()
      times = Enum.random(5..30)
      (1..times)
      |> Enum.each(
        fn _ ->
          short = Shorts.get_short!(short.id)
          Shorts.increment_visited(short)
        end
      )
      short = Shorts.get_short!(short.id)
      assert short.visited == times
    end

    test "create_short/1 with valid data creates a short" do
      url = Faker.Internet.url()
      valid_attrs = %{visited: nil, shortened: nil, original: url}

      assert {:ok, %Short{} = short} = Shorts.create_short(valid_attrs)
      assert short.visited == 0 
      assert short.short_code =~ ~r/^[[:^space:]]{6}$/
      assert short.original == url
    end


    test "a short must be a valid url" do
      Enum.each([Faker.String.base64(25),
        "htp://the.bomb",
        "http:/the.bomb",
        "httpss://the.bomb",
        "http://thebomb",
        "http://the.bomb/the bomb",
        "ahttp://the.bomb"
      ], 
      fn url -> 
        invalid_attrs = %{visited: nil, shortened: nil, original: url}
        assert {:error, %Ecto.Changeset{}} = Shorts.create_short(invalid_attrs)
      end)
    end

    test "create_short/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shorts.create_short(@invalid_attrs)
    end
  end
end
