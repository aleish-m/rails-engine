class Api::V1::Merchants::SearchController < ApplicationController 

  def show
    if search_params[:name].present?
      merchant = Merchant.search_names(search_params)
      if  merchant.nil?
        render json: MerchantSerializer.no_merchant_found, status: :not_found
      else
        render json: MerchantSerializer.single_merchant(merchant)
      end
    else
      render json: MerchantSerializer.no_merchant(400), status: :bad_request
    end
  end

  private

  def search_params 
    params.permit(:name)
  end
end