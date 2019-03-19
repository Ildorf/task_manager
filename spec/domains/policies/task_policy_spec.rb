require 'rails_helper'

RSpec.describe Policies::TaskPolicy do
  let(:user) { create(:user) }

  describe '#show?' do
    subject { described_class.new(user, record).show? }

    include_examples 'authorize record of user'
  end

  describe '#edit?' do
    subject { described_class.new(user, record).edit? }

    include_examples 'authorize record of user'
  end

  describe '#update?' do
    subject { described_class.new(user, record).update? }

    include_examples 'authorize record of user'
  end

  describe '#destroy?' do
    subject { described_class.new(user, record).destroy? }

    include_examples 'authorize record of user'
  end
end
