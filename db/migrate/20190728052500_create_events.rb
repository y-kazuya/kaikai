class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :charge
      t.string :address
      t.text :content
      t.integer :kind



      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :facility, foreign_key: true, null: false
      t.timestamps
    end
  end
end
