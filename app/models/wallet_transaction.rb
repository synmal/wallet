class WalletTransaction < ApplicationRecord
  belongs_to :transact_from, polymorphic: true
  belongs_to :transact_to, polymorphic: true

  private
  def sufficient_balance
    unless transact_from.is_a?(Wallet) && amount <= transact_from.balance
      errors.add(:amount, 'is more than wallet balance')
    end
  end

  def track_changes
    if transact_from.is_a? Wallet
      self.transact_from_initial = transact_from.balance
      self.transact_from_final = transact_from.balance - self.amount
    end

    if transact_to.is_a? Wallet
      self.transact_to_initial = transact_to.balance
      self.transact_to_final = transact_to.balance + self.amount
    end

    save!
  end
end
