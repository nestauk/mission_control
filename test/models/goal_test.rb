require "test_helper"

class GoalTest < ActiveSupport::TestCase
  setup { @subject = goals(:goal_1) }

  test('has many contributions') { assert_equal(2, @subject.contributions.size) }

  test('has many projects') { assert_equal(2, @subject.projects.size) }

  test('has many taggings') { assert_equal(2, @subject.taggings.size) }

  test('has many tags') { assert_equal(2, @subject.tags.size) }

  test('has many indicators') { assert_equal(2, @subject.indicators.size) }

  test('has many memberships') { assert_equal(4, @subject.memberships.size) }

  test('has many members') { assert_equal(4, @subject.members.size) }

  test('has many team leads') { assert_equal(2, @subject.team_leads.size) }

  test('has many team') { assert_equal(2, @subject.team.size) }

  test('has many sponsors') { assert_equal(2, @subject.sponsors.size) }

  test('title required') { assert_present(:title) }
end
