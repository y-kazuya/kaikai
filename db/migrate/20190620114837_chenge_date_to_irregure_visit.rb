class ChengeDateToIrregureVisit < ActiveRecord::Migration[5.1]
  def change
    add_column :irregular_visits, :date, :date, null: false

    remove_column :irregular_visits, :day, :integer
    remove_column :irregular_visits, :year, :integer
    remove_column :irregular_visits, :month, :integer
  end

end
