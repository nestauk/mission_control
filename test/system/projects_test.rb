require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup { @project = projects(:project_1) }

  test 'projects#index requires sign in' do
    visit projects_path
    assert_equal root_path, current_path
    assert_text 'Please sign in'
  end

  test 'projects#index' do
    sign_in
    assert_equal root_path, current_path
    assert_text 'Projects'
    assert_link @project.title
  end

  test 'projects#create' do
    sign_in
    click_link 'New project'
    fill_in :project_title, with: 'Title'
    fill_in :project_objective, with: 'Objective'
    fill_in :project_start_date, with: Date.today
    click_button 'Create'
    assert_text 'Project created'
    assert_equal project_path(Project.last), current_path
  end

  test 'projects#update' do
    sign_in
    click_link @project.title
    click_link 'Edit', href: edit_project_path(@project)
    fill_in :project_title, with: 'Updated title'
    click_button 'Update'
    assert_text 'Project updated'
    assert_equal project_path(@project), current_path
  end

  test 'projects#destroy' do
    sign_in
    click_link @project.title
    click_link 'Edit', href: edit_project_path(@project)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Project deleted'
    assert_equal projects_path, current_path
  end
end
