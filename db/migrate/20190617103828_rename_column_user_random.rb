class RenameColumnUserRandom < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :user_random, :use_random
  end
end
