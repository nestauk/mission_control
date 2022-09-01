require 'application_system_test_case'

class KeyDatesTest < ApplicationSystemTestCase
  setup do
    @project = projects(:project_1)
    sign_in
  end

  test 'key_dates#index' do
    visit project_path(@project)
    @project.key_dates.each { |date| assert_text date.title }
  end

  test 'key_dates#create' do
    visit project_path(@project)
    click_link href: new_project_key_date_path(@project)
    fill_in :key_date_date, with: Date.today
    fill_in :key_date_title, with: 'Date 3'
    click_button 'Create'
    assert_text 'Date created'
    assert_text 'Date 3'
    assert_current_path project_path(@project)
  end

  test 'key_dates#update' do
    visit project_path(@project)
    click_link href: edit_project_key_date_path(@project, @project.key_dates.first)
    fill_in :key_date_title, with: 'Updated date'
    click_button 'Update'
    assert_text 'Updated date'
    assert_current_path project_path(@project)
  end

  test 'key_dates#destroy' do
    visit project_path(@project)
    click_link href: edit_project_key_date_path(@project, @project.key_dates.first)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Date deleted'
    assert_current_path project_path(@project)
    @project.key_dates.each { |date| assert_text date.title }
  end
end
