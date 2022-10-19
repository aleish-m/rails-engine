class Api::V1::ItemMerchantsController < ApplicationController
  
  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.single_merchant(item.merchant)
  end
end