class AddDefaultTocommn < ActiveRecord::Migration[5.1]
  def change
    change_column :checks, :common, :boolean, :default => 0
  end
end
