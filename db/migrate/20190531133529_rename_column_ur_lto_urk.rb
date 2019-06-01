class RenameColumnUrLtoUrk < ActiveRecord::Migration[5.1]
  def change
    rename_column :facilities, :URL, :url
  end
end
