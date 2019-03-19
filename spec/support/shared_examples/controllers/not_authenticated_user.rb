RSpec.shared_examples 'not authenticated user' do
  it { is_expected.to redirect_to new_session_path }
end
