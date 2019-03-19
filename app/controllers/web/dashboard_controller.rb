class Web::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    tasks = Task.of_user(current_user.id)
    @task_presenters = Presenters::Task.map(tasks)
  end
end
