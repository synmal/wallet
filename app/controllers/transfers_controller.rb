class TransfersController < ApplicationController
  before_action :set_person, :set_wallet

  def create
    transfer = Transfer.new(amount: transfer_params[:amount], transact_from: @person.wallet, transact_to: @wallet)

    if transfer.save
      flash[:success] = "Transferred MYR #{transfer_params[:amount]}!"
      redirect_to dashboard_path
    else
      flash[:fail] = transfer.errors.full_messages.first
    end
  end

  private
  def transfer_params
    params.permit(:amount, :wallet_id)
  end

  def set_wallet
    @wallet = Wallet.find_by(id: params[:wallet_id])

    unless @wallet
      flash[:fail] = 'Could not find wallet'
      redirect_to dashboard_path
    end
  end
end
