require 'application_system_test_case'

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:person_1)
    sign_in
    click_link 'People'
  end

  test 'people#index requires sign in' do
    click_button 'Sign out'
    assert_requires_sign_in(people_path)
  end

  test 'people#index' do
    assert_current_path people_path
    assert_text 'People'
    assert_link @person.name
  end

  test 'people#create' do
    click_link 'New person'
    fill_in :person_first_name, with: 'First'
    fill_in :person_last_name, with: 'Last'
    click_on 'Add contact'
    find_all('input.email').each do |el|
      el.fill_in with: "email_#{el.object_id}@example.com"
    end
    all('.person_contacts_organisation').each do |el|
      within(el) { find('.choices__list').click }
      within(el) { find_all('.choices__list[role=listbox]')[0].click }
    end
    click_button 'Create'
    assert_text 'Person created'
    assert_current_path person_path(Person.last)
  end

  test 'person#update' do
    click_link @person.name, href: person_path(@person)
    click_link 'Edit', href: edit_person_path(@person)
    fill_in :person_first_name, with: 'Updated'
    click_button 'Update'
    assert_text 'Person updated'
    assert_text 'Updated value'
    assert_current_path person_path(@person)
  end

  test 'person#destroy' do
    click_link @person.name, href: person_path(@person)
    click_link 'Edit', href: edit_person_path(@person)
    page.accept_confirm { click_button 'Delete' }
    assert_text 'Person deleted'
    assert_current_path people_path
  end
end
