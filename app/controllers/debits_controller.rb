class DebitsController < ApplicationController
  before_action :set_person

  def create
    debit = Debit.new(amount: debit_params[:amount], transact_to: @person)

    if debit.save
      flash[:success] = "MYR #{debit_params[:amount]} has been withdrawn!"
    else
      flash[:fail] = debit.errors.full_messages.first
    end
    redirect_to dashboard_path
  end

  private
  def debit_params
    params.permit(:amount)
  end
end
