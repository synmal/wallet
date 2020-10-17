class Credit < WalletTransaction
  validate :only_to_crediter_wallet

  before_validation :credit_to_owner_wallet

  private
  def only_to_crediter_wallet
    crediter_wallet = transact_from.wallet
    unless transact_to.is_a?(Wallet) && transact_to.id == crediter_wallet.id
      errors.add(:transact_to, 'Can only credit to owner crediter\'s wallet')
    end
  end

  def credit_to_owner_wallet
    self.transact_to = transact_from.wallet
  end
end