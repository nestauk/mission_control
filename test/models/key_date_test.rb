require "test_helper"

class KeyDateTest < ActiveSupport::TestCase
  setup { @subject = key_dates(:key_date_1) }

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end

  test('date required') { assert_present(:date) }

  test('title required') { assert_present(:title) }
end
