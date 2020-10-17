class Debit < WalletTransaction
  validate :only_from_debiter_wallet, :sufficient_balance

  before_validation :debit_to_owner
  after_create :deduct_from_wallet

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

  def deduct_from_wallet
    Debit.transaction do
      wallet = transact_from.lock!
      wallet.balance -= amount
      wallet.save!
    end
  end
end