class Web::TasksController < ApplicationController
  policy Policies::TaskPolicy

  before_action :authenticate_user!, except: :index
  before_action :authorize_task!,    except: %i[index new create]

  def index
    tasks = Task.all_with_user
    @task_presenters = Presenters::Task.map(tasks)
  end

  def new
    @form = Forms::Admin::Task::Save.new
  end

  def show
    @task_presenter = Presenters::Task.new(task)
  end

  def create
    @form = Forms::Task::Save.new(task_params)
    if @form.valid?
      task = Commands::Task::Create.new(current_user.id).perform(@form.attributes)
      redirect_to task_path(task)
    else
      render :new
    end
  end

  def edit
    @form = Forms::Task::Save.new(task.attributes)
  end

  def update
    @form = Forms::Task::Save.new(task_params)
    if @form.valid?
      Commands::Task::Update.new(task).perform(@form.attributes)
      redirect_to task_path(task)
    else
      render :edit
    end
  end

  def destroy
    task.destroy
    redirect_to dashboard_index_path
  end

  private

  def task
    @task ||= Task.find(params[:id])
  end

  def task_params
    params.require(:form).permit!
  end

  def authorize_task!
    authorize_action!(task)
  end
end
