module Policies
  class TaskPolicy < BasePolicy
    def show?
      record_of_user?
    end

    def edit?
      record_of_user?
    end

    def update?
      record_of_user?
    end

    def destroy?
      record_of_user?
    end
  end
end
