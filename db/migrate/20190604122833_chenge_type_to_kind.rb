class ChengeTypeToKind < ActiveRecord::Migration[5.1]
  def change
    rename_column :checks, :type, :kind
  end
end
