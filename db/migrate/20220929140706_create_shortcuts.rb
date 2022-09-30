class CreateShortcuts < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcuts do |t|
      t.string :category
      t.string :title
      t.string :path
      t.string :description

      t.timestamps
    end
  end
end
