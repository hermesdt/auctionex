defmodule AuctionApp.UserTest do
  use ExUnit.Case, async: false

  import Ecto.Query

  alias AuctionApp.Models.User
  alias AuctionApp.Repo

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "given user alvaro@gmail.com already exists on the DB" do
    test "#find_by(:email, \"alvaro@gmail.com\") returns it" do
      attrs = [email: "alvaro@quiqup.com", name: "alvaro"]
      {:ok, _} = create_user(attrs)

      %User{} = User.find_by(:email, attrs[:email])
    end

    test "#create_if_not_exists do not duplicate the user" do
      attrs = [email: "alvaro@quiqup.com", name: "alvaro"]
      {:ok, _} = User.create_if_not_exists(struct(User, attrs))
      {:ok, _} = User.create_if_not_exists(struct(User, attrs))

      query = from u in User
      assert Repo.aggregate(query, :count, :id) == 1
    end
  end

  defp create_user(attrs) do
    user = struct(User, attrs) |> User.changeset(%{})
    Repo.insert(user)
  end
end
