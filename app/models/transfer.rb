class Transfer < WalletTransaction
  validate :only_wallet_to_wallet, :sufficient_balance, :only_to_different_wallet
  after_create :deduct_add_balance

  private
  def only_wallet_to_wallet
    unless transact_from.is_a?(Wallet) && transact_to.is_a?(Wallet)
      errors.add(:base, 'Transfer only available from wallet to wallet')
    end
  end

  def only_to_different_wallet
    if transact_from == transact_to
      errors.add(:base, 'Transfer only available to different wallet')
    end
  end

  def deduct_add_balance
    Transfer.transaction do
      transferer = transact_from.lock!
      transferee = transact_to.lock!
      self.track_changes

      transferer.balance -= amount
      transferer.save!
      transferee.balance += amount
      transferee.save!
    end
  end
end