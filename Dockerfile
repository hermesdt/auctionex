FROM elixir:1.8.1 as builder

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info

WORKDIR /app

ADD ./mix.exs ./
ENV MIX_ENV prod
ENV PORT 4000

ADD . .
RUN mix deps.get
RUN mkdir -p priv/static
RUN mix phx.digest
RUN mix release --env=$MIX_ENV

FROM node:11.10.0

ENV MIX_ENV prod
WORKDIR /app

COPY --from=builder /app /app
RUN cd assets && npm install
RUN cd assets ./node_modules/.bin/webpack --mode production

CMD ["_build/prod/rel/auction_app/bin/auction_app", "foreground"]
