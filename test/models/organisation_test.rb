require "test_helper"

class OrganisationTest < ActiveSupport::TestCase
  setup { @subject = organisations(:organisation_1) }

  test 'self.ordered' do
    assert_equal('Another value', Organisation.ordered.first.name)
  end

  test('has many contacts') { assert_equal(2, @subject.contacts.size) }

  test('has many memberships') { assert_equal(8, @subject.memberships.size) }

  test('name required') { assert_present(:name) }

  test 'website' do
    @subject.website = 'www.bad.url'
    @subject.valid?
    assert_error(:website, 'is not a valid URL')
  end

  test 'set_slug' do
    assert_nil(@subject.slug)
    @subject.save
    assert_equal('value', @subject.slug)
  end
end
