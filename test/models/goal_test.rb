require "test_helper"

class GoalTest < ActiveSupport::TestCase
  setup { @subject = goals(:goal_1) }

  test('has many contributions') { assert_equal(2, @subject.contributions.size) }

  test('has many projects') { assert_equal(2, @subject.projects.size) }

  test('has many taggings') { assert_equal(2, @subject.taggings.size) }

  test('has many tags') { assert_equal(2, @subject.tags.size) }

  test('has many indicators') { assert_equal(2, @subject.indicators.size) }

  test('has many links') { assert_equal(2, @subject.links.size) }

  test('has many memberships') { assert_equal(4, @subject.memberships.size) }

  test('has many members') { assert_equal(4, @subject.members.size) }

  test('has many team leads') { assert_equal(2, @subject.team_leads.size) }

  test('has many team') { assert_equal(2, @subject.team.size) }

  test('has many sponsors') { assert_equal(2, @subject.sponsors.size) }

  test('title required') { assert_present(:title) }

  test('title strip_whitespace') { assert_strip_whitespace(:title) }

  test 'self.find_puid' do
    @subject._run_create_callbacks
    @subject.save!
    assert_not_nil(Goal.find_puid(@subject.to_param))
  end

  test 'to_param' do
    @subject._run_create_callbacks
    assert_equal("goal-#{@subject.public_uid}", @subject.to_param)
  end
end
