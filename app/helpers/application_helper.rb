module ApplicationHelper
  def logged_in?
    session[:user] || session[:stock] || session[:team]
  end
end
