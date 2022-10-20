class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.all_items(Item.all)
  end

  def show
    if Item.exists?(id: params[:id])
      item = Item.find(params[:id])
      render json: ItemSerializer.single_item(item)
    else
      render json: ItemSerializer.no_item(404), status: :not_found
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.single_item(item), status: :created
    else
      if Merchant.exists?(id: item_params[:merchant_id])
        render json: ItemSerializer.no_item(400), status: :bad_request
      else
        render json: ItemSerializer.no_item(424), status: :failed_dependency
      end
    end
  end

  def destroy
    if Item.exists?(id: params[:id])
      Item.destroy(params[:id])
    else
      render json: ItemSerializer.no_item(400), status: :bad_request
    end
  end

  def update
    if Item.exists?(id: params[:id])
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.single_item(item)
      else
        render json: ItemSerializer.single_item(Item.find(params[:id])), status: :bad_request
      end
    else
      render json: ItemSerializer.no_item(404), status: :not_found
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
