class SessionsController < ApplicationController

    skip_before_action :authorized, only: [:new, :create]

    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to '/groups'
        else 
            flash[:error] = 'Log in or password is incorrect'
            redirect_to "/"
        end
    end

    def logout
        reset_session
        redirect_to '/'
    end

end