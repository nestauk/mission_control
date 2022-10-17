require "test_helper"

class CapacityTest < ActiveSupport::TestCase
  setup do
    @contact = contacts(:contact_1)
    @params = ActionController::Parameters.new(
      memberships_contact_id_in: [''],
      status_in: ['']
    )
    @subject = Capacity.new(@params)
  end

  test 'no q_params' do
    @subject = Capacity.new(nil)
    assert_nil(@subject.weeks)
    assert_nil(@subject.by_person)
  end

  test 'no status params' do
    assert_equal([], @subject.weeks)
    assert_equal({}, @subject.by_person)
  end

  test 'no memberships params' do
    assert_equal([], @subject.weeks)
    assert_equal({}, @subject.by_person)
  end

  test '#weeks' do
    @params[:memberships_contact_id_in] << @contact.id.to_s
    @subject = Capacity.new(@params)
    assert_equal(5, @subject.weeks.size)
    @subject.weeks.each { |w| assert_instance_of(Date, w) }
  end

  test '#by_person' do
    @params[:memberships_contact_id_in] << @contact.id.to_s
    @subject = Capacity.new(@params)
    project_week1_data = @subject.by_person[@contact.person.slug][0][0].keys
    project_week1_data.include?(%w(avg_time_per_week id public_uid slug title week_of))
  end
end
