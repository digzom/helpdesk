defmodule Helpdesk.Support.Ticket do
  # turns this module into a resource
  use Ash.Resource, data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:create, :read, :update, :destroy]
    
    create :open do
      # this action should only accept the :subject
      accept [:subject]
    end

    update :close do
      accept []

      change set_attribute(:status, :closed)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :subject, :string do
      allow_nil? false
    end

    attribute :status, :atom do
      constraints [one_of: [:open, :closed]]
      default :open
      allow_nil? false
    end
  end
end
