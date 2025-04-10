module Api
  module V1
    class AuthController < ApplicationController
      allow_unauthenticated_access only: [:login]

      def login
        @current_user = User.find_by(email_address: params[:email_address])
        if @current_user && @current_user.authenticate(params[:password])
          encoded_token = encode(@current_user)
          render json: { token: encoded_token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def me
        render json: @current_user
      end
    end
  end
end
