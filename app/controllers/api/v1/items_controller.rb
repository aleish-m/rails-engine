class Api::V1::ItemsController < ApplicationController 
  def index
    render json: ItemSerializer.all_items(Item.all)
  end
end
