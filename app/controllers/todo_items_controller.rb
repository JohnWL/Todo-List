class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
  
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    if @todo_item.save
      flash[:success] = "Item Saved!"
    else
      flash[:warning] = "Item Could Not Be Saved!"
    end
    redirect_to @todo_list
  end
  
  def destroy
    if @todo_item.destroy
      flash[:danger] = "Item Removed!"
    else
      flash[:warning] = "Item Could Not Be Removed!"
    end
    redirect_to @todo_list
  end
  
  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    flash[:success] = "Item Completed!"
    redirect_to @todo_list
  end
  
  
  private
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end
    
    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end
    
    def todo_item_params
      params.require(:todo_item).permit(:content)
    end
  
end
