module Policies::Admin
  class TaskPolicy < Policies::BasePolicy
    def show?
      admin?
    end

    def new?
      admin?
    end

    def create?
      admin?
    end

    def edit?
      admin?
    end

    def update?
      admin?
    end

    def destroy?
      admin?
    end
  end
end
