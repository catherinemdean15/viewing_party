class CreateJoinTablePartyUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :parties, :users do |t|
      # t.index [:party_id, :user_id]
      # t.index [:user_id, :party_id]
      t.boolean :host
    end
  end
end
