require 'rails_helper'

describe 'Item Search API' do
  describe 'search index' do
    describe 'happy path' do
      it 'returns a all matching items based on name search params' do
        item_1 = create(:item, name: 'Ring World')
        item_2 = create(:item, name: 'All the Pretty Rings')
        item_3 = create(:item, name: 'Pretty Silver Candle')
        item_4 = create(:item, name: 'Turing T-shirt')

        get '/api/v1/items/find_all?name=ring'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_a(Array)
        expect(items[:data].count).to be(3)

        items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to be_a(String)

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end
      end

      it 'returns a all matching items based on min and max price search params' do
        item_1 = create(:item, unit_price: 15)
        item_2 = create(:item, unit_price: 30)
        item_3 = create(:item, unit_price: 10)
        item_4 = create(:item, unit_price: 5)

        get '/api/v1/items/find_all?max_price=20&min_price=5'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_a(Array)
        expect(items[:data].count).to be(3)

        items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to be_a(String)

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end
      end

      it 'returns a all matching items based on min price search params' do
        item_1 = create(:item, unit_price: 15)
        item_2 = create(:item, unit_price: 3.99)
        item_3 = create(:item, unit_price: 10)
        item_4 = create(:item, unit_price: 5.99)

        get '/api/v1/items/find_all?min_price=10'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_a(Array)
        expect(items[:data].count).to be(2)

        items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to be_a(String)

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end
      end

      it 'returns a all matching items based on max price search params' do
        item_1 = create(:item, unit_price: 15)
        item_2 = create(:item, unit_price: 3.99)
        item_3 = create(:item, unit_price: 10)
        item_4 = create(:item, unit_price: 5.99)

        get '/api/v1/items/find_all?max_price=10'

        items = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_a(Array)
        expect(items[:data].count).to be(3)

        items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to be_a(String)

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end
      end
    end

    describe 'sad path' do

    end
  end
end