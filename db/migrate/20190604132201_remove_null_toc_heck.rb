class RemoveNullTocHeck < ActiveRecord::Migration[5.1]
  def change
    change_column_null :checks, :facility_id, true
  end
end
