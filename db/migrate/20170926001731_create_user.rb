class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :age
      t.string :user_type
      t.string :current_booking
      t.string :status

      t.timestamps
    end
  end
end
