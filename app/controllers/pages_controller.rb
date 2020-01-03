class PagesController < ApplicationController
    before_action :authorize!, only: :options

    def main
        render layout: false
    end
    
    def options
        @user = User.find_by(id: session[:user_id])
    end
end