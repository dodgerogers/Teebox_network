require 'openssl'

class SignedUrlsController < ApplicationController
  
  before_filter :authenticate_user!
  def index
    render json: {
      policy: s3_upload_policy_document,
      signature: s3_upload_signature,
      key: "uploads/video/file/#{SecureRandom.uuid}/#{params[:doc][:title]}",
      success_action_redirect: "/"
    }
  end

  private

  # generate the policy document that amazon is expecting.
  def s3_upload_policy_document
    Base64.encode64(
      {
        expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
        conditions: [
          { bucket: CONFIG[:s3_bucket] },
          { acl: 'public-read' },
          ["starts-with", "$key", "uploads/"],
          ["content-length-range", 0, 5242880],
          { success_action_status: '201' }
        ]
      }.to_json
    ).gsub(/\n|\r/, '')
  end

  #sign our request by Base64 encoding the policy document.
  def s3_upload_signature
    Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        CONFIG[:aws_secret_key_id],
        s3_upload_policy_document
      )
    ).gsub(/\n/, '')
  end
end

