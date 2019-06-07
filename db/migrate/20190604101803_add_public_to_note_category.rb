class AddPublicToNoteCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :note_categories, :public, :boolean, deafult: false, null: false
  end
end
