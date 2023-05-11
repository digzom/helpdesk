defmodule Helpdesk.Support.Ticket do
  # turns this module into a resource
  use Ash.Resource

  actions do
    # a set of default actions

    defaults [:create, :read, :update, :destroy]
  end

  # attributes are the simple pieces of data that exist on your resource
  attributes do
    # add autogenerated uuid primary key
    uuid_primary_key :id

    # add a string type attribute called `:subject`
    attribute :subject, :string
  end
end
