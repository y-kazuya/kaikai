class CreateCheckHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :check_histories do |t|
      t.string :type_text
      t.boolean :type_boolean

      t.references :user_check, foreign_key: true, null: false
      t.references :history, foreign_key: true, null: false
      t.timestamps
    end

    add_index :check_histories , [:user_check_id, :history_id],unique: true
  end
end
