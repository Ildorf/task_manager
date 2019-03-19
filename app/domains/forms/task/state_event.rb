class Forms::Task::StateEvent < Forms::Base
  attribute :name, Symbol

  validates :name, presence: true

  def valid?(state_machine)
    super() && validate_event(state_machine)
  end

  private

  def validate_event(state_machine)
    return true if state_machine.events.include?(name)

    errors.add(:base, "Event '#{name}' cannot transition from '#{state_machine.current_state}'.")
    false
  end
end
