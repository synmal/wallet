class Transaction < ApplicationRecord
  belongs_to :transact_from, polymorphic: true
  belongs_to :transact_to, polymorphic: true

  enum type: {
    credit: 'credit',
    debit: 'debit',
    transfer: 'transfer'
  }
end
