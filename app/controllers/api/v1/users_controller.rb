class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized
    def create
        @user = User.new(user_params)
        if @user.save!
            access_token = create_token(@user.email,1)
            refresh_token = create_token(@user.email,5)
            save_in_cache(@user.email,access_token,refresh_token)
            render "create.json",locals: {user: @user ,access_token: access_token, refresh_token: refresh_token },status: :created
             
        else
            render json: @user.erros, status: :unprocessable_entity
        end
    end
    def user_params
        params.permit(:first_name, :last_name, :email,:password,:photo , :password_confirmation)
    end
end
