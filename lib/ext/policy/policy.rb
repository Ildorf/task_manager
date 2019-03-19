module Policy
  class Base
    def initialize(user, record = nil)
      @user = user
      @record = record
    end

    def authorize!(action_name)
      permission_name = "#{action_name}?"
      raise PolicyError, "action #{action_name} not defined" unless respond_to?(permission_name)

      raise NotAuthorizedError unless public_send(permission_name)
    end

    private

    attr_reader :user, :record
  end
end
