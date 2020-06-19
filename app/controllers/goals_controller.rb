class GoalsController < ApplicationController

    def index

        if logged_in?
            if params[:category_id]
                @category = current_user.categories.find_by_id(params[:category_id])

                @goals = @category.goals.where(user_id: current_user.id)

            else 
                @goals = current_user.goals.where(user_id: current_user.id) 
                render "non_nested_index"
            end 
        else 
            redirect_to signin_path
        end 
    end 


    def show
        if logged_in?
           @goal = current_user.goals.find_by_id(params[:id])
        else 
            redirect_to signin_path
        end 
    end 

    def new 

        if logged_in?
            if params[:category_id]
                @goal = current_user.goals.build
                @category = current_user.categories.find_by_id(params[:category_id])
                
            else 
                @goal = current_user.goals.build
                @category = @goal.build_category
                render "non_nested_new"
            end 


        else 
            redirect_to signin_path
        end 
    end 

    def create 
        # need to deal if we create or find the category
        
        if logged_in?
            if !params[:goal][:category_attributes][:name].empty? && !params[:goal][:category_id].empty?
                params[:goal][:category_attributes][:name] = ""
                goal = current_user.goals.build(goal_params)
            else 
                goal = current_user.goals.build(goal_params)
            end   

            if goal.save 
                redirect_to category_goal_path(goal.category.id, goal.id)
            else 
                # need to add validations to this form 
                binding.pry 
                flash[:errors] = goal.errors.full_messages
                redirect_to new_goal_path
            end 
        else 
            redirect_to signin_path
        end 
    end 

    def edit
        if logged_in?
             
            @goal = current_user.goals.find_by_id(params[:id])
            @category = current_user.categories.find_by_id(params[:category_id])
            
        else 
            redirect_to signin_path
        end 
    end 

    def update
        if logged_in?
            @goal = current_user.goals.find_by_id(params[:id])
            @goal.update(goal_params)
            if @goal.valid?
                redirect_to category_goal_path(@goal.category.id, @goal.id)
            else 
                # need to add validations to this form 

                redirect_to goals_new_path
            end 
        else 
            #need to add error messages. 
            redirect_to signin_path
        end 
    end 



    private 


    def goal_params
        params.require(:goal).permit(:name, :details, :completed, :category_id, category_attributes: [
            :name
        ])
    end 
end
