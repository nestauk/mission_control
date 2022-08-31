require "test_helper"

class ProgressUpdateTest < ActiveSupport::TestCase
  setup { @subject = progress_updates(:progress_update_goal_1) }

  test 'self.order_recent' do
    assert_equal(@subject, ProgressUpdate.order_recent.first)
    @subject.update(date: Date.yesterday)
    assert_equal(@subject, ProgressUpdate.order_recent.last)
  end

  test 'belongs to indicator' do
    assert_instance_of(Indicator, @subject.indicator)
    assert_present(:indicator, msg: 'must exist')
  end

  test('date required') { assert_present(:date) }

  test('status required') { assert_present(:status) }

  test('value required if indicator.target_value') do
    @subject.indicator.target_value = 10
    assert_present(:value)
  end

  test 'update_indicator' do
    assert_nil(@subject.indicator.last_progress_update_date)
    assert_nil(@subject.indicator.last_progress_update_status)
    assert_nil(@subject.indicator.last_progress_update_value)
    @subject.save!
    assert_equal(@subject.date, @subject.indicator.last_progress_update_date)
    assert_equal(@subject.status, @subject.indicator.last_progress_update_status)
    assert_nil(@subject.indicator.last_progress_update_value)
  end
end
