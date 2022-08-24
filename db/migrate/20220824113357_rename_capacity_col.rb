class RenameCapacityCol < ActiveRecord::Migration[7.0]
  def change
    rename_column :memberships, :avg_weekly_time_percentage, :avg_time_per_week
  end
end
