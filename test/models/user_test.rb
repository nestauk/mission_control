require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup { @subject = users(:user_1) }

  test 'belongs to contact' do
    assert_instance_of(Contact, @subject.contact)
    assert_present(:contact, msg: 'must exist')
  end

  test('first_name required') { assert_present(:first_name) }

  test('last_name required') { assert_present(:last_name) }

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

  test('from_omniauth') { skip('todo') }
end
