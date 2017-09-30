class ChangeToFromToDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :from, :datetime
    change_column :rentals, :to, :datetime

  end
end
