require 'application_system_test_case'

class TaggingsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:goal_1)
    @goal.tags = []
    @project = projects(:project_1)
    @project.tags = []
    sign_in
  end

  test 'goal can have tags' do
    visit edit_goal_path(@goal)
    within('.goal_tags') do
      find('.choices').click
      find_all('.choices__list[role=listbox]')[0].click
    end
    click_button 'Update'
    assert_text 'Goal updated'
    assert_text '#tag-1'
    assert_current_path goal_path(@goal)
  end

  test 'project can have tags' do
    visit edit_project_path(@project)
    within('.project_tags') do
      find('.choices').click
      find_all('.choices__list[role=listbox]')[0].click
    end
    click_button 'Update'
    assert_text 'Project updated'
    assert_text '#tag-1'
    assert_current_path project_path(@project)
  end
end
