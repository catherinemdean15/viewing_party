class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.references :movie, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
