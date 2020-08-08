class Api::V1::SessionsController < ApplicationController
    before_action :authorized, only: [:auto_login]
    def create
        user = User.find_by(email: params[:email])
        if user.valid_password?(params[:password])
            token = encode_token({user_id: user.id})
            render json: {user: user , token: token} ,status: :created
        else
            head(:unauthorized)
        end
    end

    def destroy
    end
end