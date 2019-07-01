class ChengeDaysToHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :year, :integer
    add_column :histories, :month, :integer
    change_column :histories, :day, :integer
  end
end
