class Api::V1::TodoListsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    todo_lists = TdList.all

    render json: todo_lists
  end

  def create
    @todo_list = TdList.new(permitted_params)

    if @todo_list.save
      render json: {
        name: @todo_list.name
      }, status: :ok
    end
  end

  def permitted_params
    params.require(:todo_list).permit(:name)
  end
end
