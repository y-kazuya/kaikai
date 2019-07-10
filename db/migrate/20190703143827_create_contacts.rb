class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :kind


      t.timestamps
    end
  end
end
