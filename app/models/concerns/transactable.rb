module Transactable
  extend ActiveSupport::Concern

  included do
    has_many :transactions, as: :transact_from
    has_many :transactions, as: :transact_to
  end
end