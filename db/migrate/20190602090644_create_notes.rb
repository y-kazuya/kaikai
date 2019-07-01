class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :title ,null: false
      t.text :content
      t.string :image

      t.references :user, foreign_key: true, null: false
      t.references :note_category, foreign_key: true
      t.timestamps
    end

    add_index :notes , [:title, :created_at],unique: true
  end
end
