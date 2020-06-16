class SessionsController < ApplicationController
    def new 
        @user = User.new
    end 
    
    
   
    def create 
        if !auth
            @user = User.find_by(username: params[:user][:username])
            if @user
                return head(:forbidden) unless @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id 
                if @user.admin 
                    redirect_to products_path 
                else 
                    redirect_to "/genres"
                end

            else 
                redirect_to new_user_path
            end 
        else 
            @user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['name']
                u.email = auth['info']['email']
            end  
            session[:user_id] = @user.id

            redirect_to  "/genres"
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
