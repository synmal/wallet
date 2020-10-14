require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  setup do
    @team = teams(:team_one)
  end

  test "must have name" do
    assert_raise(ActiveRecord::NotNullViolation) do
      Team.create
    end
  end

  test 'name is indexed' do
    assert Team.connection.index_exists? :teams, :name
  end

  test 'name is unique' do
    @team.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      Team.create(name: 'teamOne')
    end
  end

  test 'wallet created after team created' do
    team = Team.create!(name: 'Asdf')
    assert team.wallet
  end

  test 'can only have one wallet' do
    @team.save
    assert_raise(ActiveRecord::RecordNotUnique) do
      Wallet.create(owner: @team)
    end
  end
end
