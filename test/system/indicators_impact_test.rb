require 'application_system_test_case'

class IndicatorsImpactTest < ApplicationSystemTestCase
  setup do
    @project = projects(:project_1)
    @indicator =indicators(:indicator_project_1)
    sign_in
  end

  test 'indicators#map_new_indicator_to_impact' do
    visit project_path(@project)
    click_link 'Add indicator'
    fill_in :indicator_title, with: 'Indicator with link to impact title'
    fill_in :indicator_target_value, with: 1000
    fill_in :indicator_unit, with: '£'
    find_by_id('indicator_is_impact_indicator_true').click
    find_by_id('indicator_impact_type_id').find_all('option')[1].click
    find_by_id('indicator_impact_rigour_id').find_all('option')[1].click
    find_by_id('indicator_impact_level_id').find_all('option')[1].click
    find('input[value="Create"]').click
    sleep(3)
    debugger
    assert_text 'Progress indicator created'
    assert_current_path project_path(Project.last)
    assert_text 'Impact indicator'
    assert_text 'Indicator with link to impact title'
  end


end
