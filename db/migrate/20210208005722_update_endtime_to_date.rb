class UpdateEndtimeToDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :end_time, :date
    change_column :parties, :date, :date
  end
end
