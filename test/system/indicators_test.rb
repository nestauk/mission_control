require 'application_system_test_case'

class IndicatorsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:project_1)
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
    fill_in :indicator_title, with: 'Title'
    fill_in :indicator_target_value, with: 1000
    fill_in :indicator_unit, with: '£'
    click_button 'Create'
    assert_text 'Progress indicator created'
    assert_current_path project_path(Project.last)
  end

end
