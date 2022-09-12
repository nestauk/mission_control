class AddSlugIndex < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :slug, :string

    add_index :organisations, :slug, unique: true
    add_index :people, :slug, unique: true

    remove_column :projects, :slug, :string
    add_column :projects, :public_uid, :string
    add_index  :projects, :public_uid, unique: true

    add_column :goals, :public_uid, :string
    add_index  :goals, :public_uid, unique: true
  end
end
