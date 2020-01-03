module ApplicationHelper
    def logged_in?
        !!current_user
    end
    
    # Tell me who is logged in
    def current_user
        @_current ||= User.find_by(id: session[:user_id])
    end
    
    def authorize!
        # A very simple authorization! Are you logged in? If not, let's get you started.
        redirect_to login_path if !logged_in?
    end
    
    def flash_message
        @_msg ||= flash[:message]
    end
end
