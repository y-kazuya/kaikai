class AddRandToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :use_random, :boolean, deafult: false, null: false
  end
end
