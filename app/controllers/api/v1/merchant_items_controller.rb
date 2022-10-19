class Api::V1::MerchantItemsController < ApplicationController 
  def index
    if Merchant.exists?(id: params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      render json: MerchantSerializer.items_for_merchant(merchant)
    else
      render json:MerchantSerializer.no_merchant_items, status: :not_found
    end
  end
 end

