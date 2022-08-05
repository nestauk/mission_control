require 'csv'

namespace :import do
  desc "Add organisations from a remote CSV, usage: `rake import:organisations'[http://...]'`"
  task :organisations, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      Organisation.find_or_create_by!(name: row["organisations_name"])
    end
  end

  desc "Add contacts from a remote CSV, usage: `rake import:contacts'[http://...]'`"
  task :contacts, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      org = Organisation.find_by(name: row["organisations_name"])

      person = Person.find_or_create_by!(
        first_name: row["contacts_first_name"],
        last_name: row["contacts_last_name"]
      )

      Contact.find_or_create_by!(
        person: person,
        email: row["contacts_email"],
        organisation: org,
        status: :current
      )
    end
  end

  desc "Add tags from a remote CSV, usage: `rake import:tags'[http://...]'`"
  task :tags, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      tag = Tag.find_or_initialize_by(title: row["tags_title"])
      tag.description = row["tags_description"]
      tag.save!
    end
  end

  desc "Add goals from a remote CSV, usage: `rake import:goals'[http://...]'`"
  task :goals, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      goal = Goal.find_or_initialize_by(title: row["goals_title"])
      goal.status = row["goals_status"]
      goal.context = row["goals_context"]
      goal.save!
    end
  end

  desc "Add projects from a remote CSV, usage: `rake import:projects'[http://...]'`"
  task :projects, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      project = Project.find_or_initialize_by(title: row["projects_title"])
      project.status = row["projects_status"]
      project.objective = row["projects_objective"]
      project.start_date = row["projects_start_date"]
      project.end_date = row["projects_end_date"]
      project.context = row["projects_context"]
      project.expectations = row["projects_expectations"]
      project.save!
    end
  end

  desc "Add contributions from a remote CSV, usage: `rake import:contributions'[http://...]'`"
  task :contributions, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      Contribution.find_or_create_by!(
        goal: Goal.find_by(title: row["goals_title"]),
        project: Project.find_by(title: row["projects_title"])
      )
    end
  end

  desc "Add taggings from a remote CSV, usage: `rake import:taggings'[http://...]'`"
  task :taggings, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      case row['taggings_taggable_type']
      when 'Goal'
        taggable = Goal.find_by(title: row['taggings_taggable_title'])
      when 'Project'
        taggable = Project.find_by(title: row['taggings_taggable_title'])
      end

      Tagging.find_or_create_by!(
        taggable: taggable,
        tag: Tag.find_by(title: row["taggings_tag_title"])
      )
    end
  end

  desc "Add memberships from a remote CSV, usage: `rake import:memberships'[http://...]'`"
  task :memberships, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      case row['memberships_memberable_type']
      when 'Goal'
        memberable = Goal.find_by(title: row['memberships_memberable_title'])
      when 'Project'
        memberable = Project.find_by(title: row['memberships_memberable_title'])
      end

      Membership.find_or_create_by!(
        memberable: memberable,
        contact: Contact.find_by(email: row["memberships_contact_email"]),
        role: Membership.roles[row["memberships_role"]],
        description: row["memberships_description"],
        avg_weekly_time_percentage: row["memberships_avg_weekly_time_percentage"],
      )
    end
  end

  desc "Add indicators from a remote CSV, usage: `rake import:indicators'[http://...]'`"
  task :indicators, [:url] => [:environment] do |_task, args|
    raise 'No url supplied' unless args.url.present?

    CSV.parse(URI.parse(args.url).open, headers: true) do |row|
      case row['indicators_targetable_type']
      when 'Goal'
        targetable = Goal.find_by(title: row['indicators_targetable_title'])
      when 'Project'
        targetable = Project.find_by(title: row['indicators_targetable_title'])
      end

      Indicator.create!(
        targetable: targetable,
        title: row["indicators_title"],
        target_value: row["indicators_target_value"],
        unit: row["indicators_unit"]
      )
    end
  end
end
