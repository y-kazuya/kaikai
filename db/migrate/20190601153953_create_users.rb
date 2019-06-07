class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :image
      t.integer :sex, null: false
      t.integer :care_level


      t.boolean :use_mon, null: false ,default: false
      t.boolean :use_tue, null: false ,default: false
      t.boolean :use_wed, null: false ,default: false
      t.boolean :use_thu, null: false ,default: false
      t.boolean :use_fri, null: false ,default: false
      t.boolean :use_sat, null: false ,default: false
      t.boolean :use_sun, null: false ,default: false

      t.references :facility, foreign_key: true, null: false
      t.timestamps
    end
  end
end
