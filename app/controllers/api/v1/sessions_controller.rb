class Api::V1::SessionsController < ApplicationController
    before_action :authorized, only: [:get_user ,:destroy]
    before_action :logged_in_user, only: [:get_user, :destroy]
    def create
        user = User.find_by(email: params[:email])
        if user.valid_password?(params[:password])
            access_token = create_token(user.email , 1)
            refresh_token = create_token(user.email , 20)
            #access_token = encode_token({user_id: user.id})
            save_in_cache(user.email,access_token,refresh_token)
            #render json: user.auth_token
            render "create.json" , locals: {user: user , access_token: access_token, refresh_token: refresh_token } ,status: :created 
        else
            head(:unauthorized)
        end
    end

    def destroy
        #cache = ActiveSupport::Cache::MemoryStore.new
        if Rails.cache.read(@user.email)
            Rails.cache.delete(@user.email)
            render json: "logged out", status: :ok
        else
            head(:unauthorized)
        end

        #render json: @user
    end

    def get_user
        if @user
            render "user.json", status: :ok
        else
            head(:unauthorized)
        end
    end
end