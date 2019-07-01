class AddPublicTocheck < ActiveRecord::Migration[5.1]
  def change
    add_column :checks, :public, :boolean, deafult: false, null: false
  end
end
