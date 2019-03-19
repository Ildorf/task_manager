module Policies
  class BasePolicy < Policy::Base
    private

    def record_of_user?
      user.id == record.user_id
    end

    def admin?
      user.role_admin?
    end
  end
end
