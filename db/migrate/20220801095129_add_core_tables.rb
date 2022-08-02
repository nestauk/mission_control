class AddCoreTables < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :status, default: 0
      t.timestamps
    end

    create_table :objectives do |t|
      t.string :title
      t.string :shortname
      t.string :slug
      t.integer :status, default: 0
      t.date :start_date
      t.date :end_date
      t.timestamps
    end

    create_table :contributions do |t|
      t.references :goal
      t.references :objective
      t.timestamps
    end

    create_table :indicators do |t|
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
      t.string :targetable_type
      t.bigint :targetable_id
      t.timestamps
    end

    create_table :progress_updates do |t|
      t.references :indicators
      t.references :user
      t.date :date
      t.float :value
      t.integer :status
      t.timestamps
    end
  end
end
