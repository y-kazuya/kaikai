class CreateIrregularVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :irregular_visits do |t|
      t.integer :year
      t.integer :month
      t.integer :day

      t.boolean :coming ,null: false, default: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
