class AddNameToFacility < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :name, :integer
  end
end
