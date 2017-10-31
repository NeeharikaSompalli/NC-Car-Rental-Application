json.extract! mail_notification, :id, :car_id, :customer_id, :status, :created_at, :updated_at
json.url mail_notification_url(mail_notification, format: :json)
