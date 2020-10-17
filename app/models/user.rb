class User < ApplicationRecord
  include Wallets
  include Transactable

  def name
    username
  end
end
