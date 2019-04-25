# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :markdown,
  ecto_repos: [Markdown.Repo]

# Configures the endpoint
config :markdown, MarkdownWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "erGp9S8d3Ss1Sm7T3F7E1BaecuR1cRCNzaaqsYB2DgKZd7qehgPfzynGu9G61FOv",
  render_errors: [view: MarkdownWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Markdown.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
