RSpec.shared_examples 'invalid entity' do |template|
  it { is_expected.to render_template template }

  it 'assigns form with errors' do
    subject
    expect(assigns(:form).errors).to_not be_empty
  end
end
