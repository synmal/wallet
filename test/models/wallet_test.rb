require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  setup do
    @user_wallet = wallets(:user_wallet)
    @team_wallet = wallets(:team_wallet)
    @stock_wallet = wallets(:stock_wallet)
  end

  test "balance cannot be nil" do
    @user_wallet.balance = nil
    assert_raise(ActiveRecord::NotNullViolation) do
      @user_wallet.save
    end
  end

  test "must have owner" do
    assert_raise(ActiveRecord::RecordInvalid) do
      Wallet.create!(balance: 0)
    end
  end

  test 'create wallet after user created' do
    assert true
  end

  test 'create wallet after team created' do
    assert true
  end

  test 'create wallet after stock created' do
    assert true
  end
end
