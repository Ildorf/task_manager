RSpec.shared_examples 'authorize record of user' do
  context 'when record belongs to user' do
    let(:record) { double(user_id: user.id) }

    it { is_expected.to be_truthy }
  end

  context 'when record not belongs to user' do
    let(:record) { double(user_id: user.id + 1) }

    it { is_expected.to be_falsey }
  end
end
