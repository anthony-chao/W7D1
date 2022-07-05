class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end
