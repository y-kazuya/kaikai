class RemoveTitleToNote < ActiveRecord::Migration[5.1]
  def change
    remove_index :notes,[:title, :created_at]
    remove_column :notes, :title, :string
  end
end