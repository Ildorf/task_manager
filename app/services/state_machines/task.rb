module StateMachines
  class Task < StateMachine
    state_attribute :state

    aasm do
      after_all_events :update_task
    end

    aasm do
      state :new
      state :started
      state :finished

      event :start do
        transitions from: :new, to: :started
      end

      event :finish do
        transitions from: :started, to: :finished
      end

      event :restart do
        transitions from: :finished, to: :started
      end

      event :cancel do
        transitions from: %i[started finished], to: :new
      end
    end

    private

    def update_task
      object.update!(attribute_name => aasm.current_state)
    end
  end
end
