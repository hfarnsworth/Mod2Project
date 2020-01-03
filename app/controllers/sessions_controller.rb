class SessionsController < ApplicationController

    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user
      else
        flash[:message] = "Invalid credentials"
        redirect_to login_path
      end
    end
  
    def new
  
    end
  
    def destroy
      # session[:user_id] = nil
      session.clear
      session.delete(:user_id)
      redirect_to login_path
    end
  end