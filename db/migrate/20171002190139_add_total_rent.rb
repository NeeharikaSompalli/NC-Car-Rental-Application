class AddTotalRent < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :total_cost, :integer, :default => 0
  end
end
