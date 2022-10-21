class Api::V1::Items::SearchController < ApplicationController 

  def index
    # require "pry"; binding.pry
    if name_search_params[:name].present? && !price_search_params.present?
      items = Item.search_names(name_search_params[:name])
        render json: ItemSerializer.all_items(items)
    elsif price_search_params.values.present? && !name_search_params.present?
      items = Item.search_price(price_search_params)
      render json: ItemSerializer.all_items(items)
    end
  end

  private

  def name_search_params 
    params.permit(:name)
  end

  def price_search_params
    params.permit(:max_price, :min_price)
  end
end