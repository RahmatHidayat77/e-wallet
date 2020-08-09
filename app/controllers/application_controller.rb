class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include ActionController::MimeResponds
  
    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user

    def remote_ip
      if request.remote_ip == '127.0.0.1'
        # Hard coded remote address
        '127.0.0.1'
      else
        request.remote_ip
      end
    end

    def location
      if request.remote_ip == '127.0.0.1'
        'Home'
      else
        GeoIP.new("#{Rails.root}/vendor/GeoIP.dat").country(request.remote_ip).country_name
      end
    end
  
    private
  
    # Check for valid request token and return user
    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
end
