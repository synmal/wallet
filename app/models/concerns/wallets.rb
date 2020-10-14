module Wallets
  extend ActiveSupport::Concern

  included do
    has_one :wallet, as: :owner
    after_create :create_wallet!
  end
end