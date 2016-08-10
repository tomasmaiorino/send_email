class BaseApiController < ApplicationController

	before_filter :parse_request#, :authenticate_user_from_token!

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
    Rails.logger.debug "Parsing json ->"
    if !request.body.read.nil? && !request.body.read.empty?
      @json = JSON.parse(request.body.read)
    end
  end
end
