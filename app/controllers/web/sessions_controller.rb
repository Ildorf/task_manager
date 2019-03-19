class Web::SessionsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :ensure_not_authenticated!, except: :destroy

  def new; end

  def create
    user = authenticate
    if user
      session[:user_id] = user.id
      redirect_to user.role_admin? ? admin_dashboard_index_path : dashboard_index_path
    else
      redirect_to new_session_path, alert: 'Invalid email or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def ensure_not_authenticated!
    redirect_to root_url if signed_in?
  end

  def authenticate
    command = Commands::User::Authenticate.new(params[:session][:email], params[:session][:password])
    command.perform
  end
end
