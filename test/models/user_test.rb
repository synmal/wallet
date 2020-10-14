require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:synmal)
  end

  test "must have username" do
    assert_raise(ActiveRecord::NotNullViolation) do
      User.create
    end
  end

  test 'username is indexed' do
    assert User.connection.index_exists? :users, :username
  end

  test 'username is unique' do
    @user.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      User.create(username: 'synmal')
    end
  end

  test 'wallet created after user created' do
    user = User.create!(username: 'Asdf')
    assert user.wallet
  end

  test 'can only have one wallet' do
    @user.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      Wallet.create(owner: @user)
    end
  end
end
