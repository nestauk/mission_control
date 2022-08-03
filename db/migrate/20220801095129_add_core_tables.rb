class AddCoreTables < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.string :shortname
      t.integer :status, default: 0
      t.timestamps
    end

    create_table :objectives do |t|
      t.string :title
      t.string :slug
      t.integer :status, default: 0
      t.string :objective
      t.date :start_date
      t.date :end_date
      t.integer :estimated_cost
      t.timestamps
    end

    create_table :contributions do |t|
      t.references :goal
      t.references :objective
      t.timestamps
    end

    create_table :indicators do |t|
      t.references :targetable, polymorphic: true
      t.string :title
      t.integer :status, default: 0
      t.date :start_date
      t.date :end_date
      t.string :unit
      t.float :target_value
      t.date :last_progress_update_date
      t.integer :last_progress_update_status
      t.float :last_progress_update_value
      t.integer :update_frequency, default: 0
      t.datetime :last_reminded_at
      t.timestamps
    end

    create_table :progress_updates do |t|
      t.references :indicator
      t.references :user
      t.date :date
      t.float :value
      t.integer :status
      t.timestamps
    end

    create_table :organisations do |t|
      t.string :name
      t.string :slug
      t.string :website
      t.timestamps
    end

    create_table :people do |t|
      t.string :pronouns
      t.string :first_name
      t.string :last_name
      t.string :slug
      t.timestamps
    end

    create_table :contacts do |t|
      t.references :person
      t.references :organisation
      t.string :first_name
      t.string :last_name
      t.string :slug
      t.string :email
      t.string :phone
      t.string :position
      t.integer :status, null: false
      t.timestamps
    end

    add_reference :users, :contact

    create_table :memberships do |t|
      t.references :contact
      t.references :memberable, polymorphic: true
      t.integer :role, null: false
      t.integer :role_type, null: false
      t.string :description
      t.float :avg_weekly_time_percentage
      t.timestamps
    end

    create_table :impact_ratings do |t|
      t.references :impactable, polymorphic: true
      t.integer :contribution_type, null: false
      t.string :hypothesis
      t.integer :confidence, null: false
      t.integer :no_people_reached
      t.string :audience_description
      t.string :potential_reach
      t.integer :scale_likelihood
      t.float :score
      t.timestamps
    end
  end
end
