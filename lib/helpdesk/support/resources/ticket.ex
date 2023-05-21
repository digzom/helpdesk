defmodule Helpdesk.Support.Ticket do
  # turns this module into a resource
  use Ash.Resource, data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:create, :read, :update, :destroy]
    
    create :open do
      # this action should only accept the :subject
      accept [:subject, :representative_id]
    end

    update :close do
      accept []

      change set_attribute(:status, :closed)
    end

    update :assign do
      # no attributes to be accepted
      accept []

      # we accepct a representative's id as input, with type uuid
      argument :representative_id, :uuid do
        # the action needs the id
        allow_nil? false
      end

      # this change is to replace the related Representative
      # If there is a different representative for this Ticket, it will be changeset to the new one
      # the representative itself is not modified in any way
      change manage_relationship(:representative_id, :representative, type: :append_and_remove)
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

  relationships do
    # again, we assume that the destination attribute is "representativ_id",
    # based on the name of the relationship
                # name            # destination
    belongs_to :representative, Helpdesk.Support.Representative do
      attribute_writable? true
    end
  end
end
