require 'rails_helper'

describe Commands::Task::Create do
  describe '#perform' do
    let(:user) { create(:user) }
    let(:task_params) { attributes_for(:task) }

    subject { described_class.new(user.id).perform(task_params) }

    it { is_expected.to be_instance_of(::Task) }
    it { is_expected.to be_persisted }
    its(:user_id) { is_expected.to eq user.id }
    its(:name) { is_expected.to eq task_params[:name] }
  end
end
