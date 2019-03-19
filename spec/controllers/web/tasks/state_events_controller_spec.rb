require 'rails_helper'

describe Web::Tasks::StateEventsController, type: :controller do
  let(:task) { create(:task) }
  let(:event_params) { { name: 'start' } }
  let(:task_of_user) { create(:task, user_id: user.id) }
  let(:invalid_event_params) { { attribute: :value } }

  describe 'POST #create' do
    subject { post :create, params: { task_id: task.id, event: event_params, format: :js } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      context 'task not belongs to user' do
        it { is_expected.to redirect_to root_path }
      end

      context 'task belongs to user' do
        let(:task) { task_of_user }

        context 'invalid params' do
          let(:event_params) { invalid_event_params }

          include_examples 'invalid entity', :create
        end

        context 'with valid params' do
          it { is_expected.to render_template :create }

          it 'changes task state' do
            expect { subject }.to(change { task.reload.state })
          end
        end
      end
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      context 'with invalid params' do
        let(:event_params) { invalid_event_params }

        include_examples 'invalid entity', :create
      end

      context 'with valid params' do
        it { is_expected.to render_template :create }

        it 'changes task state' do
          expect { subject }.to(change { task.reload.state })
        end
      end
    end
  end
end
