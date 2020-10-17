module ApplicationHelper
  def logged_in?
    session[:user] || session[:team] || session[:team]
  end
end
