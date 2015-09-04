class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
