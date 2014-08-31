require "json"

class AwsNotificationsController < ApplicationController
  def end_point
    notification = JSON.parse(request.raw_post, symbolize_names: true)
    logger.debug(request.raw_post)
    logger.debug("\n")
    logger.debug(notification)
    if notification[:Type] == "SubscriptionConfirmation"
      SNSConfirmation.confirm(notification[:TopicArn], notification[:Token])
    elsif notification[:Type] == "Notification"
      payload_hash = AwsVideoPayloadRepository.retrieve_payload(notification)
      VideoRepository.find_by_job_and_update(payload_hash) if payload_hash
    end
    logger.debug(notification)
    render nothing: true
  end
end