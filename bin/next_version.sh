#!/usr/bin/env bash

elixir -r lib/auction_app/git_tags.exs -e "IO.puts AuctionApp.GitTags.next_version()"
