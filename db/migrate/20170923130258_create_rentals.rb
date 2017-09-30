class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :car_id
      t.integer :customer_id
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
