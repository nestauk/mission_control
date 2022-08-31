require 'application_system_test_case'

class MembershipsTest < ApplicationSystemTestCase
  include MembershipsHelper

  setup do
    @goal = goals(:goal_1)
    @goal_membership = memberships(:membership_goal_team_lead_1)
    @project = projects(:project_1)
    @project_membership = memberships(:membership_project_team_lead_1)
    sign_in
  end

  test 'goal memberships#index requires sign in' do
    click_button 'Sign out'
    assert_requires_sign_in(memberable_memberships_path(@goal))
  end

  test 'project memberships#index requires sign in' do
    click_button 'Sign out'
    assert_requires_sign_in(memberable_memberships_path(@project))
  end

  test 'goal memberships#index' do
    visit goal_path(@goal)
    click_link href: memberable_memberships_path(@goal)
    assert_equal memberable_memberships_path(@goal), current_path
  end

  test 'project memberships#index' do
    visit project_path(@project)
    click_link href: memberable_memberships_path(@project)
    assert_equal memberable_memberships_path(@project), current_path
  end

  test 'goal memberships#create' do
    visit memberable_memberships_path(@goal)
    click_link 'Add member'
    find('.choices__list').click
    find_all('.choices__list[role=listbox]')[0].click
    choose :membership_role_team_lead
    click_button 'Create'
    assert_text 'Membership created'
    assert_equal memberable_memberships_path(@goal), current_path
  end

  test 'project memberships#create' do
    visit memberable_memberships_path(@project)
    click_link 'Add member'
    find('.choices__list').click
    find_all('.choices__list[role=listbox]')[0].click
    choose :membership_role_team_lead
    click_button 'Create'
    assert_text 'Membership created'
    assert_equal memberable_memberships_path(@project), current_path
  end

  test 'goal memberships#update' do
    visit memberable_memberships_path(@goal)
    click_link 'Edit', href: edit_memberable_membership_path(@goal, @goal_membership)
    choose :membership_role_team_member
    click_button 'Update'
    assert_text 'Membership updated'
    assert_text 'Team member', count: 1
    assert_equal memberable_memberships_path(@goal), current_path
  end

  test 'project memberships#update' do
    visit memberable_memberships_path(@project)
    click_link 'Edit', href: edit_memberable_membership_path(@project, @project_membership)
    choose :membership_role_team_member
    click_button 'Update'
    assert_text 'Membership updated'
    assert_text 'Team member', count: 1
    assert_equal memberable_memberships_path(@project), current_path
  end

  test 'goal membership#destroy' do
    visit edit_memberable_membership_path(@goal, @goal_membership)
    page.accept_confirm { click_button 'Remove member' }
    assert_text 'Membership deleted'
    assert_equal memberable_memberships_path(@goal), current_path
  end

  test 'project membership#destroy' do
    visit edit_memberable_membership_path(@project, @project_membership)
    page.accept_confirm { click_button 'Remove member' }
    assert_text 'Membership deleted'
    assert_equal memberable_memberships_path(@project), current_path
  end
end
