class CreateUserHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :user_histories do |t|

      t.date :date, null: false
      t.text :content
      t.references :user, foreign_key: true, null: false


      t.timestamps
    end
    add_index :user_histories, [:user_id, :date], unique: true


  end
end
