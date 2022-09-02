require "test_helper"

class IndicatorTest < ActiveSupport::TestCase
  setup { @subject = indicators(:indicator_goal_1) }

  test 'belongs to targetable as goal' do
    assert_instance_of(Goal, @subject.targetable)
    assert_present(:targetable, msg: 'must exist')
  end

  test 'belongs to targetable as project' do
    @subject = indicators(:indicator_project_1)
    assert_instance_of(Project, @subject.targetable)
    assert_present(:targetable, msg: 'must exist')
  end

  test('has many progress_updates') { assert_equal(2, @subject.progress_updates.size) }

  test('title required') { assert_present(:title) }

  test 'impact_type_id required if is_impact_indicator' do
    @subject.is_impact_indicator = true
    assert_present(:impact_type_id)
  end

  test 'impact_rigour_id required if is_impact_indicator' do
    @subject.is_impact_indicator = true
    assert_present(:impact_rigour_id)
  end

  test 'impact_level_id required if is_impact_indicator' do
    @subject.is_impact_indicator = true
    assert_present(:impact_level_id)
  end

  test('title strip_whitespace') { assert_strip_whitespace(:title) }

  test 'progress returns unless target_value' do
    assert_nil(@subject.target_value)
    assert_nil(@subject.progress)
  end

  test 'progress returns unless last_progress_update_value' do
    assert_nil(@subject.last_progress_update_value)
    assert_nil(@subject.progress)
  end

  test 'progress calculates' do
    @subject.target_value = 10
    @subject.last_progress_update_value = 5
    assert_equal(50.0, @subject.progress)
  end
end
