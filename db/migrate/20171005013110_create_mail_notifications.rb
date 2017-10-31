class CreateMailNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_notifications do |t|
      t.integer :car_id
      t.integer :customer_id
      t.string :status

      t.timestamps
    end
  end
end
