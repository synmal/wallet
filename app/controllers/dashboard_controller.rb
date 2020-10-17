class DashboardController < ApplicationController
  before_action :only_logged_in, :set_person

  def show
    @wallet = @person.wallet
  end
end
