require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  setup { @subject = memberships(:membership_goal_team_lead_1) }

  test 'belongs to contact' do
    assert_instance_of(Contact, @subject.contact)
    assert_present(:contact, msg: 'must exist')
  end

  test 'belongs to memberable as goal' do
    assert_instance_of(Goal, @subject.memberable)
    assert_present(:memberable, msg: 'must exist')
  end

  test 'belongs to memberable as project' do
    @subject = memberships(:membership_project_team_lead_1)
    assert_instance_of(Project, @subject.memberable)
    assert_present(:memberable, msg: 'must exist')
  end

  test('role required') { assert_present(:role) }

  test 'set_role_type team' do
    %w[team_lead team_member].each do |role|
      @subject.role = role
      @subject.valid?
      assert_equal('team', @subject.role_type)
    end
  end

  test 'set_role_type collaborator' do
    %w[collaborator].each do |role|
      @subject.role = role
      @subject.valid?
      assert_equal('collaborators', @subject.role_type)
    end
  end

  test 'set_role_type sponsor' do
    %w[sponsor coach advisor].each do |role|
      @subject.role = role
      @subject.valid?
      assert_equal('supporters', @subject.role_type)
    end
  end
end
