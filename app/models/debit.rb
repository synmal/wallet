class Debit < WalletTransaction
  validate :only_from_debiter_wallet

  before_validation :debit_to_owner

  private
  def only_from_debiter_wallet
    debiter = transact_to
    unless transact_from.is_a?(Wallet) && transact_from.owner.id == debiter.id
      errors.add(:transact_from, 'Can only debit to correct owner')
    end
  end

  def debit_to_owner
    self.transact_from = transact_to.wallet
  end
end