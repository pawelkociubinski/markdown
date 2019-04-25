use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :markdown, MarkdownWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :markdown, Markdown.Repo,
  username: "postgres",
  password: "postgres",
  database: "markdown_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
