class Web::Admin::DashboardController < ApplicationController
  policy Policies::Admin::DashboardPolicy

  before_action :authenticate_user!
  before_action :authorize_action!

  def index
    tasks = Task.all_with_user
    @task_presenters = Presenters::Task.map(tasks)
    render 'web/dashboard/index'
  end
end
