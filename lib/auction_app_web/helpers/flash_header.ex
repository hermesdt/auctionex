defmodule AuctionAppWeb.Helpers.FlashHeader do
  import Plug.Conn

  def put_flash_header(conn, key, value) do
    new_flash_header = conn
    |> get_flash_header()
    |> Map.put(key, value)

    {:ok, json_value} = new_flash_header |> Jason.encode
    conn
    |> put_private(:flash_header, new_flash_header)
    |> put_resp_header("x-flash", json_value)
  end

  def get_flash_header(conn, key) do
    get_flash_header(conn)
    |> Map.get(key, nil)
  end

  def get_flash_header(conn) do
   Map.get(conn.private, :flash_header) || %{}
  end
end
