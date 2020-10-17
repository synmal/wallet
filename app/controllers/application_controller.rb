class ApplicationController < ActionController::Base
  private
  def only_logged_in
    redirect_to root_path unless logged_in?
  end

  def logged_in?
    session[:user] || session[:stock] || session[:team]
  end
end
