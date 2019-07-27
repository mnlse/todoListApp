class TodoListsController < ApplicationController
  def create
    @todo_list = TodoList.new(permitted_params)
    @todo_list.save
    redirect_to root_path
  end


  def permitted_params
    params.require(:todo_list).permit(:name)
  end
end
