class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
  
    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end
    
    def create_token(email, expiration)
      exp = (Time.now+ expiration.minutes).to_i
      return encode_token({user_email: email , exp: exp})
    end

    def get_token
      if auth_header 
        return auth_header.split(' ')[1]
      end
    end

    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        rescue JWT::ExpiredSignature
          nil
        end
      end
    end
    
    def save_in_cache(email , access_token, refresh_token)
      value= access_token+email+refresh_token
      #cache = ActiveSupport::Cache::MemoryStore.new
      if Rails.cache.write(email,value)
        puts "wrote in cache  " + Rails.cache.read(email)
      end
    end

    def check_token_in_cache(token, email)
      cache_object = Rails.cache.read(@user.email)
      access_token_from_cache = cache_object.split(email)[0]
      refresh_token_from_cache = cache_object.split(email)[1]
      if access_token_from_cache == token
        return true
      elsif refresh_token_from_cache == token
        return true
      else  
        return false
      end
    end

    def logged_in_user
      if decoded_token 
        user_email = decoded_token[0]['user_email'].to_s
        #user_email = user_email.slice "EmailTokenJwT$^%#$151613EmailTokenJwT$"
          @user = User.find_by(email: user_email)      
      end
    end

    # def renew_access_token(refresh_token)
    #   cache_object = Rails.cache.read(@user.email)
    #   refresh_token_from_cache = cache_object.split(email)[1]
    #   if refresh_token == refresh_token_from_cache

    #   end
    # end
  
    def logged_in?
      !!logged_in_user  
    end
  
    def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless  logged_in? && check_token_in_cache(get_token , @user.email)
    end

end
