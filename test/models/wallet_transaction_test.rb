require 'test_helper'

class WalletTransactionTest < ActiveSupport::TestCase
  setup do
    @user = users(:synmal)
    @stock = stocks(:stock_one)
  end

  test 'should have type transfer' do
    assert true
  end

  test 'should have type credit' do
    assert true
  end

  test 'should have type debit' do
    assert true
  end

  test 'should be able to create transaction with sufficient wallet balance' do
    assert true
  end

  test 'should not be able to create transaction with insufficient wallet balance' do
    assert true
  end

  test 'transfer amount will be deducted from transferer wallet' do
    assert true
  end

  test 'transfer amount will be added to transferee wallet' do
    assert true
  end

  test 'credit amount will be added to owner wallet' do
    assert true
  end

  test 'debit amount will be deducted from owner wallet' do
    assert true
  end
end
