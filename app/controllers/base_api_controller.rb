require 'json'
class BaseApiController < ApplicationController

	before_filter :parse_request#, :authenticate_user_from_token!

	def set_headers
		allow_origins = Rails.application.config.allow_origins
		Rails.logger.info "Access-Control-Allow-Origin [#{allow_origins}]"
		headers['Access-Control-Allow-Origin'] = allow_origins
    headers['Access-Control-Expose-Headers'] = 'Etag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, If-Modified-Since, If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end

  private
=begin
       def authenticate_user_from_token!
         if !@json['api_token']
           render nothing: true, status: :unauthorized
         else
           @user = nil
           User.find_each do |u|
             if Devise.secure_compare(u.api_token, @json['api_token'])
               @user = u
             end
           end
         end
       end
=end
  def parse_request
    Rails.logger.debug "Request body #{request.body.read}"
    Rails.logger.debug "Request params #{request.params}"
    if !request.params.except(:action, :controller).nil? && !request.params.except(:action, :controller).empty?
      Rails.logger.debug "Valid request->"
      Rails.logger.debug "Parsing json ->"
      @json = request.params.except(:action, :controller).to_json
    end
  end
end
