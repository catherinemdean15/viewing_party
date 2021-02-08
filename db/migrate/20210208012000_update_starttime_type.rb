class UpdateStarttimeType < ActiveRecord::Migration[5.2]
  def change
    change_column :parties, :start_time, :time
  end
end
