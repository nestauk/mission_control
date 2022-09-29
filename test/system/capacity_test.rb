require 'application_system_test_case'

class CapacityTest < ApplicationSystemTestCase
  setup do
    sign_in
    @contact = contacts(:contact_1)
  end

  test 'can view resourcing table' do
    visit people_path
    click_link 'Capacity view'
    sleep 1 # to ensure choices JS loads
    find_all('.choices').first.click
    find_all('.choices__item')[0].click
    click_button 'Filter'

    assert_link @contact.person.name, href: person_path(@contact.person)
    assert_content '0 days', count: 5
  end

  test 'can toggle project breakdown' do
    visit "/people/capacity?q[memberships_contact_id_in][]=#{@contact.id}&q[status_in][]"
    click_link 'Show/hide project breakdown'
    assert_content '(0) Project 1', count: 20
  end
end
