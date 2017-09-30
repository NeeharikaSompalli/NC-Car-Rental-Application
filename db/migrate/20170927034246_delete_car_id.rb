class DeleteCarId < ActiveRecord::Migration[5.1]
  def change
    remove_column :cars, :car_id
  end
end
