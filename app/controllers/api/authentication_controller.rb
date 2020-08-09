class Api::AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
    # respond_to do |format|
    #   msg = { :status => "ok", :message => "Success!", :token => auth_token }
    #   format.json  { render :json => msg } # don't do msg.to_json
    # end
  end

  def logout
    
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
