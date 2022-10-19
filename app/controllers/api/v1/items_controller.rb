class Api::V1::ItemsController < ApplicationController 
  def index
    render json: ItemSerializer.all_items(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.single_item(item)
  end
end
