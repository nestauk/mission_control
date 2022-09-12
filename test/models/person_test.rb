require "test_helper"

class PersonTest < ActiveSupport::TestCase
  setup { @subject = people(:person_1) }

  test('has many contacts') { assert_equal(2, @subject.contacts.size) }

  test('has many users') { assert_equal(2, @subject.users.size) }

  test('has many organisations') { assert_equal(2, @subject.organisations.size) }

  test('has many memberships') { assert_equal(8, @subject.memberships.size) }

  test('has many goals') { assert_equal(4, @subject.goals.size) }

  test('has many projects') { assert_equal(4, @subject.projects.size) }

  test('first_name required') { assert_present(:first_name) }

  test('last_name required') { assert_present(:last_name) }

  test('name') { assert_equal('First Last', @subject.name) }

  test('first_name strip_whitespace') { assert_strip_whitespace(:first_name) }

  test('last_name strip_whitespace') { assert_strip_whitespace(:last_name) }

  test 'set_slug' do
    @subject.slug = nil
    assert_nil(@subject.slug)
    @subject.save!
    assert_equal('first-last', @subject.slug)
  end
end
