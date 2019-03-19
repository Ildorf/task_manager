require 'rails_helper'

describe Web::Admin::DashboardController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      it { is_expected.to render_template :index }

      context 'when tasks present in database' do
        let!(:tasks) { create_list(:task, 2) }

        before { subject }

        it 'populates an array of all tasks' do
          expect(assigns(:task_presenters)).to have_exactly(2).items
        end

        it 'populates an array of task presenters' do
          expect(assigns(:task_presenters).sample).to be_instance_of(Presenters::Task)
        end
      end
    end
  end
end
