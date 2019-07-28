class AddCummonToChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :checks, :common, :boolean, deafult: false, null: false
  end
end
