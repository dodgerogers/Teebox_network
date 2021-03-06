class SignedUrlsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    render json: {
      policy: AwsPolicyDocumentRepository.upload_policy,
      signature: AwsPolicyDocumentRepository.upload_signature,
      key: "uploads/video/#{SecureRandom.uuid}/#{params[:doc][:title]}",
      success_action_redirect: "/"
    }
  end
end

