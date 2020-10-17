class Transfer < WalletTransaction
  validate :only_wallet_to_wallet

  private
  def only_wallet_to_wallet
    unless transact_from.is_a?(Wallet) && transact_to.is_a?(Wallet)
      errors.add(:base, 'Transfer only available from wallet to wallet')
    end
  end
end