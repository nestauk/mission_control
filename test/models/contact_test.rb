require "test_helper"

class ContactTest < ActiveSupport::TestCase
  setup { @subject = contacts(:contact_1) }

  test 'belongs to person' do
    assert_instance_of(Person, @subject.person)
    assert_present(:person, msg: 'must exist')
  end

  test 'belongs to organisation' do
    assert_instance_of(Organisation, @subject.organisation)
  end

  test 'has one user' do
    assert_instance_of(User, @subject.user)
  end

  test('has many memberships') { assert_equal(8, @subject.memberships.size) }

  test('has many goals') { assert_equal(4, @subject.goals.size) }

  test('has many projects') { assert_equal(4, @subject.projects.size) }

  test('status required') { assert_present(:status) }

  test('email required') { assert_present(:email) }

  test 'email is unique' do
    @subject.email = contacts(:contact_2).email
    @subject.valid?
    assert_error(:email, 'has already been taken')
  end

  test 'email format' do
    @subject.email = 'not.an.email'
    @subject.valid?
    assert_error(:email, 'is invalid')
  end

  test 'sync_name' do
    @subject.person.update(first_name: 'updated', last_name: 'updated')
    assert_equal('value', @subject.first_name)
    assert_equal('value', @subject.last_name)
    @subject.valid?
    assert_equal('updated', @subject.first_name)
    assert_equal('updated', @subject.last_name)
  end
end
