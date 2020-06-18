class SessionsController < ApplicationController
    def new 
        if logged_in? 
            redirect_to categories_path
        else 
            @user = User.new 
        end 
    end 
    
    
   
    def create 
        if !auth
            @user = User.find_by(username: params[:user][:username])
            if @user
                return head(:forbidden) unless @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id 
                redirect_to categories_path

            else 
                flash[:errors] = "Username/password is invalid"
                redirect_to signin_path
            end 
        else 
            @user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['name']
                u.email = auth['info']['email']
            end  
            session[:user_id] = @user.id
            redirect_to categories_path
        end 
    end 


    def destroy
        session.delete :user_id
        redirect_to root_path
    end 

    private 

    def auth 
        request.env["omniauth.auth"]
    end 


end
