class Transfer < WalletTransaction
  validate :only_wallet_to_wallet, :sufficient_balance

  private
  def only_wallet_to_wallet
    unless transact_from.is_a?(Wallet) && transact_to.is_a?(Wallet)
      errors.add(:base, 'Transfer only available from wallet to wallet')
    end
  end

  def add_to_transferee

  end
end