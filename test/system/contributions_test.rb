require 'application_system_test_case'

class ContributionsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:goal_1)
    @goal.projects = []
    @project = projects(:project_1)
    sign_in
  end

  test 'goal can have projects' do
    visit edit_goal_path(@goal)
    within('.goal_projects') do
      find('.choices').click
      find_all('.choices__list[role=listbox]')[0].click
    end
    click_button 'Update'
    assert_text 'Goal updated'
    assert_current_path goal_path(@goal)
    assert_link @project.title, href: project_path(@project)
  end

  test 'project can contribute to goals' do
    visit edit_project_path(@project)
    within('.project_goals') do
      find('.choices').click
      find_all('.choices__list[role=listbox]')[0].click
    end
    click_button 'Update'
    assert_text 'Project updated'
    assert_current_path project_path(@project)
    assert_link @goal.title, href: goal_path(@goal)
  end
end
