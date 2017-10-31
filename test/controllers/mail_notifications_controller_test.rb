require 'test_helper'

class MailNotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mail_notification = mail_notifications(:one)
  end

  test "should get index" do
    get mail_notifications_url
    assert_response :success
  end

  test "should get new" do
    get new_mail_notification_url
    assert_response :success
  end

  test "should create mail_notification" do
    assert_difference('MailNotification.count') do
      post mail_notifications_url, params: { mail_notification: { car_id: @mail_notification.car_id, customer_id: @mail_notification.customer_id, status: @mail_notification.status } }
    end

    assert_redirected_to mail_notification_url(MailNotification.last)
  end

  test "should show mail_notification" do
    get mail_notification_url(@mail_notification)
    assert_response :success
  end

  test "should get edit" do
    get edit_mail_notification_url(@mail_notification)
    assert_response :success
  end

  test "should update mail_notification" do
    patch mail_notification_url(@mail_notification), params: { mail_notification: { car_id: @mail_notification.car_id, customer_id: @mail_notification.customer_id, status: @mail_notification.status } }
    assert_redirected_to mail_notification_url(@mail_notification)
  end

  test "should destroy mail_notification" do
    assert_difference('MailNotification.count', -1) do
      delete mail_notification_url(@mail_notification)
    end

    assert_redirected_to mail_notifications_url
  end
end
