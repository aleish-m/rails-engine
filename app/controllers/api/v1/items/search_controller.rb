class Api::V1::Items::SearchController < ApplicationController 

  def index
    # require "pry"; binding.pry
    if name_search_params[:name].present? && !price_search_params.present?
      items = Item.search_names(name_search_params[:name])
      if items.count == 0
        render json: ItemSerializer.no_items_found
      else
        render json: ItemSerializer.all_items(items)
      end
    elsif price_search_params.values.present? && !name_search_params.present? && price_search_params.values.all?{|price| price.to_i.positive?}
      items = Item.search_price(price_search_params)
      if items.count == 0
        render json: ItemSerializer.no_items_found
      else
        render json: ItemSerializer.all_items(items)
      end
    else
      render json: ItemSerializer.no_item(400), status: :bad_request
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