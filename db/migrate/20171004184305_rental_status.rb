class RentalStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :status, :string
    remove_column :rentals, :user_id
  end
end
