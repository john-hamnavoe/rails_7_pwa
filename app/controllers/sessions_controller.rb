class SessionsController < ApplicationController
  def create
    user = User.find_by(id: params[:id])
    log_in user
    redirect_to root_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
