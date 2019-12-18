class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
 
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.create(hidden_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to '/groups'
        else
            flash[:error] = @user.errors.full_messages
            render :new
        end
    end


    
    private

        
    def hidden_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
