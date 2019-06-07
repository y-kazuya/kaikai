class CreateUserChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_checks do |t|

      t.references :user, foreign_key: true, null: false
      t.references :check, foreign_key: true, null: false
      t.timestamps
    end
    add_index :user_checks , [:user_id, :check_id],unique: true
  end
end
