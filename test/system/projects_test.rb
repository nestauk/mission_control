require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:project_1)
    @project._run_create_callbacks
    @project.save!
    sign_in
  end

  test 'projects#index requires sign in' do
    click_button 'Sign out'
    assert_requires_sign_in(projects_path)
  end

  test 'projects#index' do
    assert_current_path root_path
    assert_text 'Projects'
    assert_link @project.title
  end

  test 'projects#create' do
    click_link 'New project'
    fill_in :project_title, with: 'Title'
    fill_in :project_objective, with: 'Objective'
    fill_in :project_start_date, with: Date.today
    click_button 'Create'
    assert_text 'Project created'
    assert_current_path project_path(Project.last)
  end

  test 'projects#update' do
    click_link @project.title
    click_link 'Edit', href: edit_project_path(@project)
    fill_in :project_title, with: 'Updated title'
    click_button 'Update'
    assert_text 'Project updated'
    assert_text 'Updated title'
    assert_current_path project_path(@project)
  end

  test 'projects#destroy' do
    click_link @project.title
    click_link 'Edit', href: edit_project_path(@project)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Project deleted'
    assert_current_path projects_path
  end
end
