class DashboardController < ApplicationController
  before_action :only_logged_in, :set_person

  def show
    @wallet = @person.wallet
    @transactions = WalletTransaction.where(transact_to: @person).or(WalletTransaction.where(transact_from: @person))
  end
end
