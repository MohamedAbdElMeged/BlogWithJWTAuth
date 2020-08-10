class Api::V1::SessionsController < ApplicationController
    before_action :authorized, only: [:get_user , :destroy]
    #before_action :logged_in_user, only: [:get_user]
    def create
        user = User.find_by(email: params[:email])
        if user.valid_password?(params[:password])
            access_token = create_token(user.email , 2)
            refresh_token = create_token(user.email , 5)
            save_in_cache(user.email,access_token,refresh_token)
            #render json: user.auth_token
            render "create.json" , locals: {user: user , access_token: access_token , refresh_token: refresh_token} ,status: :created
        else
            head(:unauthorized)
        end
    end

    def destroy
        #cache = ActiveSupport::Cache::MemoryStore.new
        Rails.cache.delete(@user.email)
        render json: "logout out"
        #render json: Rails.cache.read().split(@user.email)[0]
    end

    def get_user
        render "user.json", status: :ok
    end
end