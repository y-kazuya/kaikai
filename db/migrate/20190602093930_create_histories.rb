class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.date :day, null: false
      t.text :content

      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
    add_index :histories , [:user_id, :day],unique: true
  end
end
