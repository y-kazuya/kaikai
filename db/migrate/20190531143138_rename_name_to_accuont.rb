class RenameNameToAccuont < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :name, :string
  end
end
