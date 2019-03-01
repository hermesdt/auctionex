defmodule AuctionApp.GitTags do
  require Logger

  def get_version_type do
    {:ok, version_type} = File.read("VERSION_TYPE")
    version_type
  end

  def next_version do
    [major, minor, patch] = last_version()

    next_version = get_version_type()
    |> case do
      "MAJOR" -> [major + 1, 0, 0]
      "MINOR" -> [major, minor + 1, 0]
      "PATCH" -> [major, minor, patch + 1]
    end
    |> Enum.join(".")

    "v" <> next_version
  end

  def last_version do
    get_git_tags()
    |> Tuple.to_list
    |> Enum.at(0)
    |> String.split("\n")
    |> Enum.map(fn(t) ->
        case Regex.run(~r/^"v(\d+\.\d+\.\d+)"$/, t) do
          [_, version] -> version
          nil -> nil
        end
      end)
    |> Enum.filter(&(not is_nil(&1)))
    |> case do
      [last_version | _] ->
        last_version
        |> String.split(".")
        |> Enum.map(&String.to_integer/1)
      _ ->
        [0, 0, 0]
    end
  end

  def get_git_tags do
    System.cmd("git", ["tag", "-l", "--format", "\"%(refname:short)\"", "--sort=-version:refname", "--merged", "HEAD"])
  end
end
