class CategoriesController < ApplicationController
    def index
        if logged_in?
            @categories = current_user.categories.uniq
        else 
            redirect_to signin_path
        end 
    end 

    # def new 
    #     if logged_in?
   
    #         # #@user = current_user
    #         # @goals = current_user.goals.build
    #         # @category = @goals.build_category

    #     else 
    #         redirect_to signin_path
    #     end 
    # end 

    # def create
    #     if logged_in?
    #         #need to have a goal. likely a nested form
    #         binding.pry
    #         goal = current_user.goals.build(goal_params)
    #         binding.pry
    #         #category = current_user.goals.build.build_category(category_params)
    #         #category = current_user.categories.where(name: params[:category][:name]).first_or_create(category_params)
    #         binding.pry
    #         if category.valid?
    #             redirect_to categories_path
    #         else 
    #             #need to add validation to the categories models and user flash and category.errors to provide error messages
    #             redirect_to new_category_path
    #         end 

    #     else 
    #         redirect_to signin_path
    #     end 
    # end 


    # private

    # def category_params
    #     params.require(:category).permit(:name, goals_attributes: [
    #         :name,
    #         :details
    #     ])
    # end 


end
