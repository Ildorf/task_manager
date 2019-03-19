require 'rails_helper'

describe Web::SessionsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to render_template :new }

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { session: session } }

    let(:user) { create(:user, password: 'password') }
    let(:session) { { email: email, password: password } }
    let(:email) { user.email }
    let(:password) { 'password' }

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'user with given email does not exist' do
      let(:email) { 'not-exist@example.com' }

      it { is_expected.to redirect_to new_session_path }
    end

    context 'password invalid' do
      let(:password) { 'invalid password' }

      it { is_expected.to redirect_to new_session_path }
    end

    context 'email and password correct' do
      it { is_expected.to redirect_to dashboard_index_path }
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end
  end
end
