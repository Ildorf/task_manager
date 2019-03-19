require 'rails_helper'

describe Forms::Task::StateEvent do
  describe '#valid?' do
    subject { described_class.new(state_event_params).valid?(state_machine) }

    let(:state_event_params) { { name: event } }
    let(:state_machine) { double(events: %i[finish cancel], current_state: :started) }

    context 'possible events include event' do
      let(:event) { :finish }

      it { is_expected.to be_truthy }
    end

    context 'possible events not include event' do
      let(:event) { :start }

      it { is_expected.to be_falsey }
    end
  end
end
