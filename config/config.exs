# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :fuck_beme, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:fuck_beme, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :extwitter, :oauth, [
   consumer_key: "6zN3O0PGQoPmTrfkD16c1oQ0L",
   consumer_secret: "WNDniFMHf5nbqDp1kJVALY97jrqebt7DDWHOzSQ48B2MWkKhMT",
   access_token: "755234636666642434-ZbMwfNwvDCOu6g3YzpIHpEwi55Yyxfu",
   access_token_secret: "tp3aP32heVk6KH7geY0r08qQ7iunI5JqL2mUUj6f41ppn"
]