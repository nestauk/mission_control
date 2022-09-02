class AddImpactIndicatorsTables < ActiveRecord::Migration[7.0]
  def change
    create_table :impact_types do |t|
      t.string :title, null: false
      t.integer :category, null: :false
      t.timestamps
    end

    create_table :impact_rigours do |t|
      t.references :impact_type
      t.string :title, null: false
      t.integer :rating, null: false
      t.timestamps
    end

    create_table :impact_levels do |t|
      t.references :impact_rigour
      t.string :title, null: false
      t.integer :rating, null: false
      t.timestamps
    end

    add_column :indicators, :is_impact_indicator, :boolean, default: false
    add_reference :indicators, :impact_type
    add_reference :indicators, :impact_rigour
    add_reference :indicators, :impact_level
  end
end
