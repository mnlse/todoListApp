class Api::V1::TodoListsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_todo_list, only: [:show, :destroy]

  def show
    @todo_list = TdList.includes(:todo_items).find(params[:id])
    @todo_items = @todo_list.todo_items

    returnval = {
      todo_list: @todo_list, 
      todo_items: @todo_items
    }

    render json: returnval
  end

  def index
    todo_lists = TdList.all

    render json: todo_lists
  end

  def create
    @todo_list = TdList.new(permitted_params)

    if @todo_list.save
      render json: @todo_list, status: :ok
    end
  end

  def destroy
    if @todo_list.destroy
      render json: {
        name: @todo_list.name
      }, status: :ok
    end
  end

  private
  def set_todo_list
    @todo_list = TdList.find(params[:id])
  end

  def permitted_params
    params.require(:todo_list).permit(:name)
  end
end
