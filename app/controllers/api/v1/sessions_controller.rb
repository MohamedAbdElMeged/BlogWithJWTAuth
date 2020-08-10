class Api::V1::SessionsController < ApplicationController
    before_action :authorized, only: [:get_user , :destroy]
    #before_action :logged_in_user, only: [:get_user]
    def create
        user = User.find_by(email: params[:email])
        if user.valid_password?(params[:password])
            exp = (Time.now+ 2.minutes).to_i
            refresh_exp = (Time.now+ 5.minutes).to_i
            access_token = encode_token({user_email: user.email , exp: exp})
            refresh_token = encode_token({user_email: user.email , exp: refresh_exp})

            render "create.json" , locals: {user: user , access_token: access_token , refresh_token: refresh_token} ,status: :created
        else
            head(:unauthorized)
        end
    end

    def destroy
    end

    def get_user
        render "user.json", status: :ok
    end
end