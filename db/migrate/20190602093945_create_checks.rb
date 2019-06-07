class CreateChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :checks do |t|
      t.string :title, null: false
      t.integer :type, null: false

      t.references :facility, foreign_key: true, null: false
      t.timestamps
    end
  end
end
