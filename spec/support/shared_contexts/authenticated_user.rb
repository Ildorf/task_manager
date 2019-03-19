RSpec.shared_context 'authenticated user' do
  let(:user) { create(:user) }

  before { @request.session[:user_id] = user.id }
end
