class Api::V1::MerchantsController < ApplicationController 
  def index
    render json: MerchantSerializer.all_merchants(Merchant.all)
  end

  def show
    if Merchant.exists?(id: params[:id])
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.single_merchant(merchant)
    else
      render json: MerchantSerializer.no_merchant, status: :not_found
    end
  end

end