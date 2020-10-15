class User < ApplicationRecord
  include Wallets
  include Transactable
end
