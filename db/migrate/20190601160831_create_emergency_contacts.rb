class CreateEmergencyContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :emergency_contacts do |t|
      t.string :name, null: false
      t.string :relation
      t.string :email
      t.string :tel
      t.integer :pref
      t.string :city
      t.string :address

      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
