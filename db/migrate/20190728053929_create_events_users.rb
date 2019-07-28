class CreateEventsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :events_users do |t|


      t.references :user, foreign_key: true, null: false
      t.references :event, foreign_key: true, null: false
      t.timestamps
    end
    add_index :events_users, [:user_id, :event_id], unique: true
  end
end
