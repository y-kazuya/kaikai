class CreateNoteCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :note_categories do |t|
      t.string :name , null: false

      t.references :facility, foreign_key: true
      t.timestamps
    end

    add_index :note_categories, [:name, :facility_id], unique: true
    add_index :users, [:name, :created_at],unique: true
  end
end
