class CategoriesController < ApplicationController
    def index
        if logged_in?
            @categories = current_user.categories.uniq
        else 
            redirect_to signin_path
        end 
    end 

    def destroy
        if logged_in?
            @category = current_user.categories.find_by_id(params[:id])
            if @category
                @category.goals.where(user_id: current_user.id).delete_all
                current_user.categories.delete(@category)
            end
            redirect_to categories_path
        else 
            redirect_to signin_path
        end 
    end


end
