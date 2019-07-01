class AddDefaultTouser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :use_random, :boolean, :default => false
  end
end
