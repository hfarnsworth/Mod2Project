class UsersController < ApplicationController
    before_action :authorize!, except: [:new, :create]

    def new
        @user = User.new
    end

    def create
        user = User.new(params.require(:user).permit(:username, :password))
        if user.valid?
            user.save
            # session[:user_id] = user.id
        end
        redirect_to login_path
    end
    
    def show
        redirect_to options_path
    end
end