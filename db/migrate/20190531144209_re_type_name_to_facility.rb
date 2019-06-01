class ReTypeNameToFacility < ActiveRecord::Migration[5.1]
  def change
    change_column :facilities, :name, :text
  end
end
