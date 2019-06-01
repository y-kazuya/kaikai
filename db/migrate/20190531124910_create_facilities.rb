class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :URL
      t.string :image
      t.string :email
      t.string :tel
      t.integer :pref
      t.string :city
      t.string :address
      t.timestamps
    end
  end
end
