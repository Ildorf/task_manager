module Policies::Admin
  class DashboardPolicy < Policies::BasePolicy
    def index?
      admin?
    end
  end
end
