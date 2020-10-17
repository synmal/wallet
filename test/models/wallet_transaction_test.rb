require 'test_helper'
##
# Test validation on credit and debit and transfer transact_from/transact_to type
class WalletTransactionTest < ActiveSupport::TestCase
  setup do
    @user = users(:synmal)
    @stock = stocks(:stock_one)
    @team = teams(:team_one)
  end

  test 'should have type transfer' do
    transfer = Transfer.new(amount: 0, transact_from: @user.wallet, transact_to: @stock.wallet)
    # byebug
    transfer.save
    assert transfer.type == 'transfer'
  end

  test 'should only transfer from wallet to wallet' do
    [@user, @team, @stock].each do |u|
      transfer = Transfer.new(amount: 0, transact_from: u, transact_to: u.wallet)
      assert_not transfer.save
    end

    [@user, @team, @stock].each do |u|
      transfer = Transfer.new(amount: 0, transact_from: u.wallet, transact_to: u)
      assert_not transfer.save
    end
  end

  test 'should have type credit' do
    credit = Credit.new(amount: 0, transact_from: @user, transact_to: @user.wallet)
    credit.save
    assert credit.type == 'credit'
  end

  test 'should automatically point to owners wallet' do
    credit = Credit.new(amount: 0, transact_from: @user)
    assert credit.save
    assert credit.transact_from == credit.transact_to.owner
  end

  test 'should have type debit' do
    debit = Debit.new(amount: 0, transact_from: @user.wallet, transact_to: @user)
    debit.save
    assert debit.type == 'debit'
  end

  test 'should automatically point to wallet owner' do
    debit = Debit.new(amount: 0, transact_to: @user)
    assert debit.save
    assert debit.transact_to == debit.transact_from.owner
  end

  test 'should not be able to create transfer with insufficient wallet balance' do
    transfer = Transfer.new(amount: 1000000, transact_from: @user.wallet, transact_to: @stock.wallet)
    assert_not transfer.save
  end

  test 'should not be able to create debit with insufficient wallet balance' do
    debit = Debit.new(amount: 1000000, transact_to: @user)
    assert_not debit.save
  end

  # test 'transfer amount will be deducted from transferer wallet' do
  #   assert true
  # end

  # test 'transfer amount will be added to transferee wallet' do
  #   assert true
  # end

  # test 'credit amount will be added to owner wallet' do
  #   assert true
  # end

  # test 'debit amount will be deducted from owner wallet' do
  #   assert true
  # end
end
