require 'rails_helper'

describe Web::Admin::TasksController, type: :controller do
  let(:task) { create(:task) }
  let(:task_params) { attributes_for(:task).merge(user_id: create(:user).id) }
  let(:invalid_task_params) { { attribute: :value } }

  describe 'GET #show' do
    subject { get :show, params: { id: task.id } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      it { is_expected.to render_template :show }
    end
  end

  describe 'GET #new' do
    subject { get :new }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { form: task_params } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      context 'invalid task params' do
        let(:task_params) { invalid_task_params }

        include_examples 'invalid entity', :new
      end

      context 'valid task params' do
        it { is_expected.to redirect_to admin_task_path(Task.last) }

        it 'creates new task in database' do
          expect { subject }.to(change(Task, :count).by(1))
        end
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: task.id } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      it { is_expected.to render_template :edit }
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: { id: task.id, form: task_params } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      context 'with invalid params' do
        let(:task_params) { invalid_task_params }

        include_examples 'invalid entity', :edit
      end

      context 'with valid params' do
        it { is_expected.to redirect_to admin_task_path(task) }

        it 'changes task user_id' do
          expect { subject }.to(change { task.reload.user_id }.to(task_params[:user_id]))
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: task.id } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to redirect_to root_path }
    end

    context 'authenticated admin' do
      include_context 'authenticated admin'

      let!(:task) { create(:task) }

      it { is_expected.to redirect_to admin_dashboard_index_path }

      it 'deletes task from database' do
        expect { subject }.to(change(Task, :count).by(-1))
      end
    end
  end
end
