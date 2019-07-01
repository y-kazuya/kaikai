class CreateUserCheckHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :user_check_histories do |t|
      t.text :text_content
      t.boolean :check_content


      t.references :user_history, foreign_key: true, null: false
      t.references :user_check, foreign_key: true, null: false
      t.timestamps
    end
    add_index :user_check_histories, [:user_history_id, :user_check_id], unique: true
  end
end
