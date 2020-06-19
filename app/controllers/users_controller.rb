class UsersController < ApplicationController

    def new 
        if logged_in? 
            redirect_to categories_path
        else 
            @user = User.new 
        end 
    end

    def create
        if params[:user][:password] != params[:user][:password_confirmation]
            redirect_to signup_path
        else
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id 
                redirect_to categories_path
            else 
                flash[:errors] = @user.errors.full_messages.uniq
                redirect_to signup_path
            end 
        end 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end

end
