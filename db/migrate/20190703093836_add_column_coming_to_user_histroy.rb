class AddColumnComingToUserHistroy < ActiveRecord::Migration[5.1]
  def change
    add_column :user_histories, :coming, :boolean, deafult: true, null: false
  end
end
