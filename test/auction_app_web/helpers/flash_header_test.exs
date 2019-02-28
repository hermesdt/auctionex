defmodule AuctionAppWeb.Plugs.FlashHeaderTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import AuctionAppWeb.Helpers.FlashHeader

  test "flash_header is initially empty" do
    flash_header = conn(:get, "/")
    |> get_flash_header()

    assert flash_header == %{}
  end

  test "put_flash_header adds X-Flash http header" do
    header = conn(:get, "/")
    |> put_flash_header(:info, "foo")
    |> get_resp_header("x-flash")

    assert header == ["{\"info\":\"foo\"}"]
  end

  test "put_flash_header adds X-Flash http header with info an error" do
    header = conn(:get, "/")
    |> put_flash_header(:info, "foo")
    |> put_flash_header(:error, "baz")
    |> get_resp_header("x-flash")

    assert header == ["{\"error\":\"baz\",\"info\":\"foo\"}"]
  end
end
