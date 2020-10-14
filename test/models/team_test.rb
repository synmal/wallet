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
end
