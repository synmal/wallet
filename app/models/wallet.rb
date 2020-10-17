class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true

  delegate :name, to: :owner
end
