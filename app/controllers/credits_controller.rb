class CreditsController < ApplicationController
  before_action :set_person

  def create
    credit = Credit.new(amount: credit_params[:amount], transact_from: @person)

    if credit.save
      flash[:success] = "MYR #{credit_params[:amount]} has been deposited!"
    else
      flash[:fail] = "Something went wrong please try again later"
    end
    redirect_to dashboard_path
  end

  private
  def credit_params
    params.permit(:amount)
  end
end
