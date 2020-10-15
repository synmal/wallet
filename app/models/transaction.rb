class Transaction < ApplicationRecord
  belongs_to :transact_from
  belongs_to :transact_to, polymorphic: true
end
