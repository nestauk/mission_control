require 'application_system_test_case'

class GoalsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:goal_1)
    sign_in
    click_link 'Goals'
  end

  test 'goals#index requires sign in' do
    click_button 'Sign out'
    assert_requires_sign_in(goals_path)
  end

  test 'goals#index' do
    assert_equal goals_path, current_path
    assert_text 'Goals'
    assert_link @goal.title
  end

  test 'goals#create' do
    click_link 'New goal'
    fill_in :goal_title, with: 'Title'
    click_button 'Create'
    assert_text 'Goal created'
    assert_equal goal_path(Goal.last), current_path
  end

  test 'goals#update' do
    click_link @goal.title, href: goal_path(@goal)
    click_link 'Edit', href: edit_goal_path(@goal)
    fill_in :goal_title, with: 'Updated title'
    click_button 'Update'
    assert_text 'Goal updated'
    assert_text 'Updated title'
    assert_equal goal_path(@goal), current_path
  end

  test 'goals#destroy' do
    click_link @goal.title, href: goal_path(@goal)
    click_link 'Edit', href: edit_goal_path(@goal)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Goal deleted'
    assert_equal goals_path, current_path
  end
end
