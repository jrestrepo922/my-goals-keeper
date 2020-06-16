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
        
        if params[:user][:password] != params[:user][:password_confirmation]
            redirect_to signup_path
        else
            if params[:user][:admin] == "1"
                @user = User.new(user_params) 
                if @user.save 
                    @user.update(admin: true)
                    session[:user_id] = @user.id 
                    redirect_to products_path 
                else
                    flash[:errors] = @user.errors.full_messages.uniq
                    redirect_to signup_path
                end 

            else 
                @user = User.new(user_params)
                if @user.save
                    session[:user_id] = @user.id 
                    redirect_to "/genres" 
                else 
                    
                    flash[:errors] = @user.errors.full_messages.uniq
                    redirect_to signup_path
                end 

            end  
        end 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end

end
