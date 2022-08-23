class RenamePlanningToScoping < ActiveRecord::Migration[7.0]
  def change
    rename_column :projects, :planning_start_date, :scoping_start_date
  end
end
