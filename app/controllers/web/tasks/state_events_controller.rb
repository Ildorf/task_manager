class Web::Tasks::StateEventsController < ApplicationController
  policy Policies::Tasks::StateEventPolicy

  before_action :authenticate_user!
  before_action :authorize_task!

  def create
    @form = Forms::Task::StateEvent.new(task_params)
    state_machine = StateMachines::Task.new(task)
    return unless @form.valid?(state_machine)

    state_machine.fire(@form.name)
    @task_presenter = Presenters::Task.new(task)
  end

  private

  def task
    @task ||= Task.find(params[:task_id])
  end

  def task_params
    params.require(:event).permit!
  end

  def authorize_task!
    authorize_action!(task)
  end
end
