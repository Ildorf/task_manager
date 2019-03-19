require 'rails_helper'

describe Commands::User::Authenticate do
  describe '#perform' do
    let(:user) { create(:user, password: 'password') }
    let(:email) { user.email }
    let(:password) { 'password' }

    subject { described_class.new(email, password).perform }

    context 'when user with given email does not exist' do
      let(:email) { 'user@example.com' }

      it { is_expected.to be_nil }
    end

    context 'when password invalid' do
      let(:password) { 'invalid' }

      it { is_expected.to be_nil }
    end

    context 'when email and password correct' do
      it { is_expected.to eq user }
    end
  end
end
