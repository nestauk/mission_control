require "test_helper"

class ContributionTest < ActiveSupport::TestCase
  setup { @subject = contributions(:contribution_1) }

  test 'belongs to goal' do
    assert_instance_of(Goal, @subject.goal)
    assert_present(:goal, msg: 'must exist')
  end

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end
end
