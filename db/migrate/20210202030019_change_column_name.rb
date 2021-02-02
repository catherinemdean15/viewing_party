class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_registered?, :boolean, default: false
  end
end
