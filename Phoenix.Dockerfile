FROM elixir:1.15.4

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new --force
RUN apt-get update
RUN apt-get install -y postgresql-client
