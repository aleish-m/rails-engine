class Api::V1::MerchantItemsController < ApplicationController

  def index
    if Merchant.exists?(id: params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.all_items(merchant.items)
    else
      render json:MerchantSerializer.no_merchant_items, status: :not_found
    end
  end
  
 end

