class Api::V1::TodoItemsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }


  def create
    @todo_item = TodoItem.new(permitted_params)
    @todo_item.td_list = TdList.find(params[:todo_list_id])
    @todo_item.save!

    render json: @todo_item
  end

  def destroy
    @todo_item = TodoItem.find(params[:id])
    if @todo_item.destroy!
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  private
  def permitted_params
    params.require(:todo_item).permit(:name, :todo_list_id)
  end
end
