class WalletTransaction < ApplicationRecord
  belongs_to :transact_from, polymorphic: true
  belongs_to :transact_to, polymorphic: true

  enum type: {
    credit: 'Credit',
    debit: 'Debit',
    transfer: 'Transfer'
  }
end
