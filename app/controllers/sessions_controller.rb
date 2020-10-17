class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user
      session[:user_id] = user.id
      flash[:success] = 'Successfully Logged In'
      redirect_to dashboard_path
    else
      flash[:fail] = 'Login Failed'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged Out'
    redirect_to root_path
  end
end
