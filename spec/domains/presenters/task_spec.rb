require 'rails_helper'

describe Presenters::Task do
  let(:task) { create(:task, attachment: file) }
  let(:file) { double(url: 'url', file: { filename: 'name' }) }

  subject { described_class.new(task) }

  its(:id) { is_expected.to eq(task.id) }
  its(:name) { is_expected.to eq(task.name) }
  its(:description) { is_expected.to eq(task.description) }
  its(:state) { is_expected.to eq(task.state) }
  its(:attachment) { is_expected.to be_instance_of(Presenters::File) }
end
