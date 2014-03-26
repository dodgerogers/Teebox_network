require "json"

class AwsNotificationsController < ApplicationController
  def end_point
    notification = JSON.parse(request.raw_post)
    if notification["Type"] == "SubscriptionConfirmation"
      SNSConfirmation.confirm(notification["TopicArn"], notification["Token"])
    elsif notification["Type"] == "Notification"
      Video.retrieve_payload(notification)
    end
    logger.debug(notification)
    render nothing: true
  end
end