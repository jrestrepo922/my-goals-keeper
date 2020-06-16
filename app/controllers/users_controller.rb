class UsersController < ApplicationController

    def new 
        if logged_in? 
            if params[:user][:admin] == "1"
                redirect_to products_path
            else 
                redirect_to "genres"
            end
            
        else 
            @user = User.new 
        end 
    end

    def create
        binding.pry
        if params[:user][:password] != params[:user][:password_confirmation]
            redirect_to signup_path
        else
            if params[:user][:admin] == "1"
                @user = User.create(user_params) 
                @user.update(admin: true)
                session[:user_id] = @user.id 
                binding.pry
                redirect_to products_path 
            else 
                @user = User.create(user_params) 
                session[:user_id] = @user.id 
                redirect_to "/genres" 
            end  
        end 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end

end
