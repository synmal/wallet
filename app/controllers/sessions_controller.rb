class SessionsController < ApplicationController
  before_action :logout_existing

  def create
    user = params[:type].constantize.first

    if user
      set_session user.id
      flash[:success] = 'Successfully Logged In'
      redirect_to dashboard_path
    else
      flash[:fail] = 'Login Failed'
      redirect_to root_path
    end
  end

  def destroy
    flash[:success] = 'Logged Out'
    redirect_to root_path
  end

  private
  def set_session(id)
    session[params[:type].downcase.to_sym] = id
  end

  def logout_existing
    ['user', 'team', 'stock'].each do |u|
      session[u.to_sym] = nil
    end
  end
end
