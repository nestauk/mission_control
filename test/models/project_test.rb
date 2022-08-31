require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup { @subject = projects(:project_1) }

  test('has many key_dates') { assert_equal(2, @subject.key_dates.size) }

  test('has many contributions') { assert_equal(2, @subject.contributions.size) }

  test('has many goals') { assert_equal(2, @subject.goals.size) }

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

  test('objective required') { assert_present(:objective) }

  test('status required') { assert_present(:status) }

  test('start_date required') { assert_present(:start_date) }

  test('title strip_whitespace') { assert_strip_whitespace(:title) }
end
