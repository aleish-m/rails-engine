class Api::V1::ItemMerchantsController < ApplicationController
  def index
    if Item.exists?(id: params[:item_id])
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.single_merchant(item.merchant)
    else
      render json: MerchantSerializer.no_merchant(404), status: :not_found
    end
  end
end
