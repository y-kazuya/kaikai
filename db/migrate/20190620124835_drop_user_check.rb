class DropUserCheck < ActiveRecord::Migration[5.1]
  def change
    drop_table :check_histories
  end
end
