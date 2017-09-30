class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :car_name
      t.integer :car_id
      t.string :car_model
      t.float :car_price
      t.timestamps
    end
  end
end
