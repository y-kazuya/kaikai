class AddAcuuontIdToFacility < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :account_id, :integer
  end
end
