require 'application_system_test_case'

class TaggingsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:goal_1)
    @goal.tags = []
    @goal._run_create_callbacks
    @goal.save!
    @project = projects(:project_1)
    @project.tags = []
    @project._run_create_callbacks
    @project.save!
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
