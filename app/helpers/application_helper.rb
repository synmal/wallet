module ApplicationHelper
  def logged_in?
    session[:user] || session[:stock] || session[:team]
  end

  def current_person
    if session[:user]
      User.find_by(id: session[:user])
    elsif session[:stock]
      Stock.find_by(id: session[:stock])
    elsif session[:team]
      Team.find_by(id: session[:team])
    end
  end
end
