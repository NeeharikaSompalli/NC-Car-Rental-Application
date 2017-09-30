class AddColumsCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :manufacturer, :string
    add_column :cars, :style, :string
    add_column :cars, :is_approved, :string
    add_column :cars, :location, :string
    add_column :cars, :license_plate, :string
    add_column :cars, :status, :string
  end
end
