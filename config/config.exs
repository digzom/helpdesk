import Config

config :ash, :use_all_identities_in_manage_relationship?, false

# adding the api
config :helpdesk, :ash_apis, [Helpdesk.Support]
