module Policy
  module Controller
    module ClassMethods
      def policy(class_name)
        raise 'policy alredy defined' if policy_class

        @policy_class = class_name
      end

      attr_reader :policy_class
    end

    def authorize_action!(record = nil)
      policy = policy_class.new(current_user, record)
      policy.authorize!(action_name)
    end

    def policy_class
      self.class.policy_class
    end
  end
end
