require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  setup { @subject = taggings(:tagging_goal_1) }

  test 'belongs to tag' do
    assert_instance_of(Tag, @subject.tag)
    assert_present(:tag, msg: 'must exist')
  end

  test 'belongs to taggable as goal' do
    assert_instance_of(Goal, @subject.taggable)
    assert_present(:taggable, msg: 'must exist')
  end

  test 'belongs to taggable as project' do
    @subject = taggings(:tagging_project_1)
    assert_instance_of(Project, @subject.taggable)
    assert_present(:taggable, msg: 'must exist')
  end
end
