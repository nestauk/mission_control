class AddMetadataToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :ambition, :integer
    add_column :projects, :geography, :integer
    add_column :projects, :phase, :integer
    add_column :projects, :project_code, :string

    add_column :projects, :impact_statement, :string
    add_column :projects, :impact_type, :integer

    create_table :key_dates do |t|
      t.references :project
      t.string :title
      t.date :date
      t.timestamps
    end
  end
end
