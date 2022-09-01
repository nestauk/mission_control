require "test_helper"

class LinkTest < ActiveSupport::TestCase
  setup { @subject = links(:link_goal_1) }

  test 'belongs to linkable as goal' do
    assert_instance_of(Goal, @subject.linkable)
    assert_present(:linkable, msg: 'must exist')
  end

  test 'belongs to linkable as project' do
    @subject = links(:link_project_1)
    assert_instance_of(Project, @subject.linkable)
    assert_present(:linkable, msg: 'must exist')
  end

  test('url required') { assert_present(:url) }

  test('name required') { assert_present(:name) }

  test 'url' do
    @subject.url = 'www.bad.url'
    @subject.valid?
    assert_error(:url, 'enter a valid website address e.g. http://www.example.com')
  end
end
