RSpec.shared_context 'authenticated admin' do
  let(:user) { create(:user, :admin) }

  before { @request.session[:user_id] = user.id }
end
