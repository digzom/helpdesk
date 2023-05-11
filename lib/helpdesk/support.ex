defmodule Helpdesk.Support do
  use Ash.Api

  resources do
    # this defines the set of resources that can be used with this api
    registry Helpdesk.Support.Registry
  end
end
