require 'rails_helper'

describe 'Merchant API' do
  describe 'merchant index' do
    describe 'happy path' do
      it 'sends a list of all merchants' do
        create_list(:merchant, 4)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(4)

        merchants[:data].each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_a(String)

          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_a(String)

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)

          expect(merchant).to_not have_key(:created_at)
          expect(merchant).to_not have_key(:updated_at)
        end
      end
    end

    describe 'sad path' do
      it 'sends a empty list of merchants if there are no merchants' do
        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(0)

        expect(merchants[:data]).to be_an(Array)
      end
    end
  end

  describe 'merchant show' do 
    describe 'happy path' do
      it 'can get a single merchant by its id' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_a(Hash)

        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_a(String)

        expect(merchant[:data]).to have_key(:type)
        expect(merchant[:data][:type]).to be_a(String)

        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes]).to be_a(Hash)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)

        expect(merchant[:data]).to_not have_key(:created_at)
        expect(merchant[:data]).to_not have_key(:updated_at)
      end
    end

    describe 'sad path' do
      it 'returns a 404 status code and a empty merchant hash when a invalid merchant id is requested' do
        get '/api/v1/merchants/1'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(merchant).to have_key(:status)
        expect(merchant[:status]).to be_a(String)

        expect(merchant).to have_key(:error)
        expect(merchant[:error]).to be_a(Hash)

        expect(merchant[:error]).to have_key(:id)
        expect(merchant[:error][:id]).to be(nil)

        expect(merchant[:error]).to have_key(:type)
        expect(merchant[:error][:type]).to be_a(String)
      end
    end
  end

  describe 'merchant items' do
    describe 'happy path' do 
      it 'can get all items for a given merchant ID' do
        id = create(:merchant).id
        create_list(:item, 5, merchant_id: id)

        get "/api/v1/merchants/#{id}/items"

        merchant_items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant_items).to have_key(:data)
        expect(merchant_items[:data]).to be_an(Array)

        merchant_items[:data].each do |item|
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

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)

          expect(item).to_not have_key(:created_at)
          expect(item).to_not have_key(:updated_at)
        end
      end
    end

    describe 'sad path' do 
      it 'returns a empty merchant items data hash when a invalid merchant id is requested' do
        get '/api/v1/merchants/1/items'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(merchant).to have_key(:status)
        expect(merchant[:status]).to be_a(String)

        expect(merchant).to have_key(:error)
        expect(merchant[:error]).to be_a(Array)

        expect(merchant[:error][0]).to have_key(:id)
        expect(merchant[:error][0][:id]).to be(nil)

        expect(merchant[:error][0]).to have_key(:type)
        expect(merchant[:error][0][:type]).to be_a(String)
      end
    end
  end
end
