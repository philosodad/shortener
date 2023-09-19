# Shortener

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## This application

This application is mostly Phoenix boilerplate with a few exceptions.

* `/lib/shortener` contains the business logic and schema for Shortening URLs
* `/lib/shortener_web/controllers/short_controller.ex` has the routing logic for the server.
• `/lib/shortener_web/controllers/short_html/` contains the `.heex` files for display.
