require 'rails_helper'

describe Web::TasksController, type: :controller do
  let(:task) { create(:task) }
  let(:task_params) { attributes_for(:task) }
  let(:task_of_user) { create(:task, user_id: user.id) }
  let(:invalid_task_params) { { attibure: :value } }

  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to render_template :index }

    context 'tasks present in database' do
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

  describe 'GET #show' do
    subject { get :show, params: { id: task.id } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      context 'task not belongs to user' do
        it { is_expected.to redirect_to root_path }
      end

      context 'task belongs to user' do
        let(:task) { task_of_user }

        it { is_expected.to render_template :show }

        it 'assigns task presenters' do
          subject
          expect(assigns(:task_presenter)).to be_instance_of(Presenters::Task)
        end
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { form: task_params } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      context 'invalid params' do
        let(:task_params) { invalid_task_params }

        include_examples 'invalid entity', :new
      end

      context 'valid params' do
        it { is_expected.to redirect_to task_path(Task.last) }

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

      context 'task not belongs to user' do
        it { is_expected.to redirect_to root_path }
      end

      context 'task belongs to user' do
        let(:task) { task_of_user }

        it { is_expected.to render_template :edit }
      end
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: { id: task.id, form: task_params } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      context 'task not belongs to user' do
        it { is_expected.to redirect_to root_path }
      end

      context 'task belongs to user' do
        let(:task) { task_of_user }

        context 'invalid params' do
          let(:task_params) { invalid_task_params }

          include_examples 'invalid entity', :edit
        end

        context 'valid params' do
          it { is_expected.to redirect_to task_path(task) }

          it 'changes task name' do
            expect { subject }.to(change { task.reload.name }.to(task_params[:name]))
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: task.id } }

    include_examples 'not authenticated user'

    context 'authenticated user' do
      include_context 'authenticated user'

      context 'task not belongs to user' do
        it { is_expected.to redirect_to root_path }
      end

      context 'task belongs to user' do
        let!(:task) { task_of_user }

        it { is_expected.to redirect_to dashboard_index_path }

        it 'deletes task from database' do
          expect { subject }.to(change(Task, :count).by(-1))
        end
      end
    end
  end
end
