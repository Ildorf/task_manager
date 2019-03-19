require 'rails_helper'

describe Commands::Task::Update do
  describe '#perform' do
    let(:task) { create(:task) }
    let(:task_params) { attributes_for(:task) }

    subject { described_class.new(task).perform(task_params) }

    it { is_expected.to be_instance_of(::Task) }

    it 'changes task name' do
      expect { subject }.to(change { task.reload.name }.to(task_params[:name]))
    end
  end
end
