class StateMachine
  include AASM

  def initialize(object)
    raise "'state_attribute' not defined" unless attribute_name

    @object = object
    initial_state = object.public_send(attribute_name).to_sym
    self.class.aasm.initial_state(initial_state)
  end

  def attribute_name
    self.class.attribute_name
  end

  delegate :fire, :current_state, to: :aasm

  def events
    aasm.events.map(&:name)
  end

  class << self
    def state_attribute(attribute_name)
      @attribute_name = attribute_name
    end

    attr_reader :attribute_name
  end

  private_class_method :state_attribute

  private

  attr_reader :object
end
