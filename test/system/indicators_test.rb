require 'application_system_test_case'

class IndicatorsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:project_1)
    @indicator =indicators(:indicator_project_1)
    # sign_in
  end

  # TODO wip test cannot be checked or run until okta setup fix
  # test 'indicators#new requires sign in' do
  #   click_button 'Sign out'
  #   assert_requires_sign_in(new_project_indicator_path(@project))
  # end

  test 'indicators#create' do
    visit project_path(@project)
    click_link 'Add indicator'
    fill_in :indicator_title, with: 'Indicator title'
    fill_in :indicator_target_value, with: 1000
    fill_in :indicator_unit, with: '£'
    save_and_open_page
    fill_in :indicator_description, with: 'First stab at describing'
    click_button 'Create'
    assert_text 'Progress indicator created'
    assert_current_path project_path(Project.last)
    assert_text 'Indicator title'
  end

  test 'indicators#update' do
    visit project_path(@project)
    click_link @indicator.title
    click_link 'Edit', href: edit_project_indicator_path(project_id: @project.id, id: @indicator.id)
    fill_in :indicator_title, with: 'Updated title'
    fill_in :indicator_description, with: 'This is what the indicator is all about'
    click_button 'Update'
    assert_text 'Progress indicator updated'
    assert_text 'Updated title'
    assert_text 'This is what the indicator is all about'
    assert_current_path project_path(@project)
  end

end
