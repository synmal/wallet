class WalletTransaction < ApplicationRecord
  belongs_to :transact_from, polymorphic: true
  belongs_to :transact_to, polymorphic: true

  private
  def sufficient_balance
    unless transact_from.is_a?(Wallet) && amount <= transact_from.balance
      errors.add(:amount, 'amount is more than wallet balance')
    end
  end
end
