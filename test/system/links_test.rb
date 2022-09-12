require 'application_system_test_case'

class LinksTest < ApplicationSystemTestCase
  include LinksHelper

  setup do
    @goal = goals(:goal_1)
    @goal._run_create_callbacks
    @goal.save!
    @project = projects(:project_1)
    @project._run_create_callbacks
    @project.save!
    sign_in
  end

  test 'goal links#index' do
    visit goal_path(@goal)
    @goal.links.each { |link| assert_link link.name }
  end

  test 'project links#index' do
    visit project_path(@project)
    @project.links.each { |link| assert_link link.name }
  end

  test 'goal links#create' do
    visit goal_path(@goal)
    click_link href: new_linkable_link_path(@goal)
    fill_in :link_url, with: 'https://www.example.com'
    fill_in :link_name, with: 'Link 3'
    click_button 'Create'
    assert_text 'Link created'
    assert_current_path goal_path(@goal)
    assert_link 'Link 3'
  end

  test 'project links#create' do
    visit project_path(@project)
    click_link href: new_linkable_link_path(@project)
    fill_in :link_url, with: 'https://www.example.com'
    fill_in :link_name, with: 'Link 3'
    click_button 'Create'
    assert_text 'Link created'
    assert_current_path project_path(@project)
    assert_link 'Link 3'
  end

  test 'goal links#update' do
    visit goal_path(@goal)
    click_link href: edit_linkable_link_path(@goal, @goal.links.first)
    fill_in :link_name, with: 'Updated link'
    click_button 'Update'
    assert_text 'Link updated'
    assert_current_path goal_path(@goal)
    assert_link 'Updated link'
  end

  test 'project links#update' do
    visit project_path(@project)
    click_link href: edit_linkable_link_path(@project, @project.links.first)
    fill_in :link_name, with: 'Updated link'
    click_button 'Update'
    assert_text 'Link updated'
    assert_current_path project_path(@project)
    assert_link 'Updated link'
  end

  test 'goal links#destroy' do
    visit goal_path(@goal)
    click_link href: edit_linkable_link_path(@goal, @goal.links.first)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Link deleted'
    assert_current_path goal_path(@goal)
    @goal.links.each { |link| assert_link link.name }
  end

  test 'project links#destroy' do
    visit project_path(@project)
    click_link href: edit_linkable_link_path(@project, @project.links.first)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Link deleted'
    assert_current_path project_path(@project)
    @project.links.each { |link| assert_link link.name }
  end
end
