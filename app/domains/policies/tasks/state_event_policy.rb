module Policies::Tasks
  class StateEventPolicy < Policies::BasePolicy
    def create?
      record_of_user? || admin?
    end
  end
end
