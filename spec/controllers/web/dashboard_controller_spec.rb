require 'rails_helper'

describe Web::DashboardController, type: :controller do
  describe 'GET #index' do
    let(:make_request) { get :index }

    subject { make_request }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to render_template :index }

      context 'when tasks of user present in database' do
        let!(:tasks) { create_list(:task, 2, user_id: user.id) }

        it 'populates an array of all tasks of user' do
          make_request
          expect(assigns(:task_presenters)).to have_exactly(2).items
        end

        it 'populates an array of task presenters' do
          make_request
          expect(assigns(:task_presenters).sample).to be_instance_of(Presenters::Task)
        end
      end

      context 'when tasks of other users present in database' do
        let!(:tasks) { create_list(:task, 2) }

        it 'not populates an array of other users tasks' do
          make_request
          expect(assigns(:task_presenters)).to be_empty
        end
      end
    end
  end
end
