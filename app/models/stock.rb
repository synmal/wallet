class Stock < ApplicationRecord
  include Wallets
  include Transactable
end
