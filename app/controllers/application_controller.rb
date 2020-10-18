class ApplicationController < ActionController::Base
  private
  def only_logged_in
    redirect_to root_path unless logged_in?
  end

  def logged_in?
    session[:user] || session[:stock] || session[:team]
  end

  def set_person
    redirect_to root_path unless logged_in?

    if session[:user]
      @person = User.find_by(id: session[:user])
    elsif session[:stock]
      @person = Stock.find_by(id: session[:stock])
    elsif session[:team]
      @person = Team.find_by(id: session[:team])
    end
  end
end
