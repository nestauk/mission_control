class AddPlanningStartDateToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :planning_start_date, :date
  end
end
