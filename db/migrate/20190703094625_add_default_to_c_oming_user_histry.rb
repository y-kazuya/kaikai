class AddDefaultToCOmingUserHistry < ActiveRecord::Migration[5.1]
  def change
    change_column :user_histories, :coming, :boolean, default: true
  end
end
