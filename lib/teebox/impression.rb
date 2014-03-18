require "active_support/concern"

module Teebox::Impression
  extend ActiveSupport::Concern
  
  def self.create(object, request)
    @impression = object.impressions.build(ip_address: request.remote_ip)
    if @impression.save
      Rails.logger.debug("#{@impression.attributes} Created\n")
    end
  end
end