require 'test_helper'

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
    assert transfer.type == 'Transfer'
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
    assert credit.type == 'Credit'
  end

  test 'should automatically point to owners wallet' do
    credit = Credit.new(amount: 0, transact_from: @user)
    assert credit.save
    assert credit.transact_from == credit.transact_to.owner
  end

  test 'should have type debit' do
    debit = Debit.new(amount: 0, transact_from: @user.wallet, transact_to: @user)
    debit.save
    assert debit.type == 'Debit'
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

  test 'transfer amount will be added/deducted from transferee/transferer wallet' do
    @user.wallet.update!(balance: 10)
    @stock.wallet.update!(balance: 10)
    amount = (1..10).to_a.sample
    transfer = Transfer.create(amount: amount, transact_from: @user.wallet, transact_to: @stock.wallet)
    assert (10 - amount.to_f) == transfer.transact_from.reload.balance
    assert (10 + amount.to_f) == transfer.transact_to.reload.balance
  end

  test 'credit amount will be added to owner wallet' do
    @user.wallet.update!(balance: 10)

    amount = (1..10).to_a.sample
    credit = Credit.create(amount: amount, transact_from: @user)
    assert (10 + amount.to_f) == credit.transact_to.reload.balance
  end

  test 'debit amount will be deducted from owner wallet' do
    @user.wallet.update!(balance: 10)

    amount = (1..10).to_a.sample
    credit = Debit.create(amount: amount, transact_to: @user)
    assert (10 - amount.to_f) == credit.transact_from.reload.balance
  end
end
