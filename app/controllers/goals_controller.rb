class GoalsController < ApplicationController

    before_action :get_goal, only:[:show, :edit, :update]

    def index

        if logged_in?
            
        
            if params[:category_id]
                #user try to change the path
                if !current_user.categories.find_by_id(params[:category_id])

                    redirect_to root_path
                else 
                    @category = current_user.categories.find_by_id(params[:category_id])
                    @goals = @category.goals.where(user_id: current_user.id)
                end 

            else 
                @goals = current_user.goals.where(user_id: current_user.id) 
                render "non_nested_index"
            end 
            
        else 
            redirect_to signin_path
        end 
    end 


    def show
        if !current_user.goals.find_by_id(params[:id]) || !current_user.categories.find_by_id(params[:category_id])
            redirect_to root_path
        else 
            if logged_in?
                #    @goal = current_user.goals.find_by_id(params[:id])
                else 
                    redirect_to signin_path
                end            
        end 

    end 

    def new 

        if logged_in?
            if params[:category_id]

                if !current_user.categories.find_by_id(params[:category_id])
                    redirect_to root_path
                else 
                    @goal = current_user.goals.build
                    @category = current_user.categories.find_by_id(params[:category_id])
                end   
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
        
        if logged_in?

            if params[:category_id] 
                # if both are selected, the create and Existing 
                if !params[:goal][:category_attributes][:name].empty? && !params[:goal][:category_id].empty?
                    params[:goal][:category_attributes][:name] = ""
                    goal = current_user.goals.build(goal_params)
                    if goal.save 
                        redirect_to category_goal_path(goal.category.id, goal.id)
                    else 
                        flash[:errors] = goal.errors.full_messages
                        redirect_to new_goal_path
                    end
                # if one is empty from create or Existing 
                else 
                    goal = current_user.goals.build(goal_params)

                    if goal.save 
                        redirect_to category_goal_path(goal.category.id, goal.id)
                    else 
                        flash[:errors] = goal.errors.full_messages
                        redirect_to new_goal_path
                    end 
                end   
            #this one is for the nested form create that does not need a category Id     
            else !params[:category_id] 
                goal = current_user.goals.build(goal_params)

                if goal.save 
                    redirect_to category_goal_path(goal.category.id, goal.id)
                else 
                    flash[:errors] = goal.errors.full_messages
                    redirect_to new_goal_path
                end 
            end 

        else 
            redirect_to signin_path
        end 
    end 

    def edit
        if logged_in?
             
            # @goal = current_user.goals.find_by_id(params[:id])
            @category = current_user.categories.find_by_id(params[:category_id])
            
        else 
            redirect_to signin_path
        end 
    end 

    def update
        if logged_in?
            # @goal = current_user.goals.find_by_id(params[:id])
            @goal.update(goal_params)
            if @goal.valid?
                redirect_to category_goal_path(@goal.category.id, @goal.id)
            else 
                # need to add validations to this form 
                flash[:errors] = @goal.errors.full_messages
                
                redirect_to edit_category_goal_path(@goal.category.id, @goal.id)
            end 
        else 
            
            redirect_to signin_path
        end 
    end 



    private 


    def goal_params
        params.require(:goal).permit(:name, :details, :completed, :category_id, category_attributes: [
            :name
        ])
    end 

    def get_goal
        @goal = current_user.goals.find_by_id(params[:id])
    end 
end
