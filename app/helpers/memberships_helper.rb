module MembershipsHelper
  def memberable_memberships_path(memberable)
    send("#{to_var(memberable)}_memberships_path", memberable)
  end

  def memberable_membership_path(memberable, membership)
    send("#{to_var(memberable)}_membership_path", memberable, membership)
  end

  def new_memberable_membership_path(memberable)
    send("new_#{to_var(memberable)}_membership_path", memberable)
  end

  def edit_memberable_membership_path(memberable, membership)
    send("edit_#{to_var(memberable)}_membership_path", memberable, membership)
  end

  def role_type_description(role_type)
    {
      team: "The people accountable for delivering results.",
      collaborators: "The people providing specialist support but not part of the team or accountable for its results.",
      supporters: "The people accountable for setting up and supporting teams to deliver results."
    }.with_indifferent_access[role_type]
  end

  private

  def to_var(memberable)
    memberable.class.to_s.underscore
  end
end
