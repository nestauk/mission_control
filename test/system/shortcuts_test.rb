require 'application_system_test_case'

class ShortcutsTest < ApplicationSystemTestCase
  setup { sign_in }

  test 'goal shortcut' do
    click_link 'Goal Shortcut'
    assert_current_path(goals_path)
  end

  test 'person shortcut' do
    click_link 'Person Shortcut'
    assert_current_path(people_path)
  end

  test 'project shortcut' do
    click_link 'Project Shortcut'
    assert_current_path(projects_path)
  end
end
