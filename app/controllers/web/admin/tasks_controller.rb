class Web::Admin::TasksController < ApplicationController
  policy Policies::Admin::TaskPolicy

  before_action :authenticate_user!
  before_action :authorize_action!

  def new
    @form = Forms::Admin::Task::Save.new
    render '/web/tasks/new'
  end

  def show
    @task_presenter = Presenters::Task.new(task)
    render '/web/tasks/show'
  end

  def create
    @form = Forms::Admin::Task::Save.new(task_params)
    if @form.valid?
      task = Commands::Task::Create.new(@form.user_id).perform(@form.attributes)
      redirect_to admin_task_path(task)
    else
      render '/web/tasks/new'
    end
  end

  def edit
    @form = Forms::Admin::Task::Save.new(task.attributes)
    render '/web/tasks/edit'
  end

  def update
    @form = Forms::Admin::Task::Save.new(task_params)
    if @form.valid?
      Commands::Task::Update.new(task).perform(@form.attributes)
      redirect_to admin_task_path(task)
    else
      render '/web/tasks/edit'
    end
  end

  def destroy
    task.destroy
    redirect_to admin_dashboard_index_path
  end

  private

  def task
    @task ||= Task.find(params[:id])
  end

  def task_params
    params.require(:form).permit!
  end
end
