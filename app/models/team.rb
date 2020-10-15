class Team < ApplicationRecord
  include Wallets
  include Transactable
end
