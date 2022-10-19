class Api::V1::ItemsController < ApplicationController 
  def index
    render json: ItemSerializer.all_items(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.single_item(item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.single_item(item), status: :created
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.single_item(item) 
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
