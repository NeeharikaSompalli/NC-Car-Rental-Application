class ChangeColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :rentals, :from, :start_time
    rename_column :rentals, :to, :end_time
  end
end
