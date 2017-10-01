class AddReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :user, index: true
  end
end
