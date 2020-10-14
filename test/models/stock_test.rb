require 'test_helper'

class StockTest < ActiveSupport::TestCase
  setup do
    @stock = stocks(:stock_one)
  end

  test "must have name" do
    assert_raise(ActiveRecord::NotNullViolation) do
      Stock.create
    end
  end

  test 'name is indexed' do
    assert Stock.connection.index_exists? :stocks, :name
  end

  test 'name is unique' do
    @stock.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      Stock.create(name: 'stockOne')
    end
  end

  test 'wallet created after stock created' do
    stock = Stock.create!(name: 'Asdf')
    assert stock.wallet
  end

  test 'can only have one wallet' do
    @stock.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      Wallet.create(owner: @stock)
    end
  end
end
