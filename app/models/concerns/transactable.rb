module Transactable
  extend ActiveSupport::Concern

  included do
    # has_many :wallet_transactions, as: :transact_from
    # has_many :wallet_transactions, as: :transact_to

    has_many :transfers, as: :transact_from
    has_many :credits, as: :transact_from
    has_many :debits, as: :transact_to
  end
end