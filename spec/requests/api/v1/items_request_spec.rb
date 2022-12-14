require 'rails_helper'

describe 'Items API' do
  describe 'item index' do
    describe 'happy path' do
      it 'sends a list of all items' do
        create_list(:item, 5)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(5)

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

          expect(item).to_not have_key(:created_at)
          expect(item).to_not have_key(:updated_at)
        end
      end
    end

    describe 'sad path' do
      it 'sends a empty list of items if there are no items' do
        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(0)

        expect(items[:data]).to be_an(Array)
      end
    end
  end

  describe 'show item' do
    describe 'happy path' do
      it 'can get a single item by its id' do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_a(Hash)

        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_a(String)

        expect(item[:data]).to have_key(:type)
        expect(item[:data][:type]).to be_a(String)

        expect(item[:data]).to have_key(:attributes)
        expect(item[:data][:attributes]).to be_a(Hash)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_a(Float)

        expect(item[:data][:attributes]).to have_key(:merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

        expect(item[:data]).to_not have_key(:created_at)
        expect(item[:data]).to_not have_key(:updated_at)
      end
    end

    describe 'sad path' do
      it 'returns a 404 status code and a empty item hash when an invalid item id is requested' do
        get '/api/v1/items/1'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end
    end
  end

  describe 'create item' do
    describe 'happy path' do

      it 'can create a new item' do
        merchant = create(:merchant)
        item_params = {
          name: 'Motivational Cross Stitch',
          description: 'Handmade cross stich picture with a motivational quote',
          unit_price: 5.99,
          merchant_id: merchant.id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

        created_item = Item.last

        expect(response).to have_http_status(201)

        expect(created_item.name).to eq(item_params[:name])
        expect(created_item.description).to eq(item_params[:description])
        expect(created_item.unit_price).to eq(item_params[:unit_price])
        expect(created_item.merchant_id).to eq(item_params[:merchant_id])
      end
    end

    describe 'sad path' do
      it 'returns a 400 status code and a empty item hash when an invalid info is provided for an item' do
        merchant = create(:merchant)
        item_params = {
          name: 'Motivational Cross Stitch',
          unit_price: 5.99,
          merchant_id: merchant.id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end

      it 'returns a 424 status code and a empty item hash when an invalid merchant id is provided when creating a item' do
        item_params = {
          name: 'Motivational Cross Stitch',
          description: 'Handmade cross stich picture with a motivational quote',
          unit_price: 5.99,
          merchant_id: 1
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(424)

        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end
    end
  end

  describe 'destroy item' do
    describe'happy path' do 

      it 'can destroy an item' do
        id = create(:item).id

        expect(Item.count).to eq(1)

        delete "/api/v1/items/#{id}"

        expect(response).to have_http_status(204)

        expect(Item.count).to eq(0)
        expect { Item.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'sad path' do
      it "returns a error hash for item when trying ot delete an item that does not exist in db" do
        delete "/api/v1/items/2"
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end
    end
  end

  describe 'update item' do
    describe 'happy path' do
      describe 'can update an existing item' do
        it 'can update only one part of an items information' do
          id = create(:item).id
          previous_name = Item.last.name

          update_params = { name: 'Silver necklace' }
          headers = { 'CONTENT_TYPE' => 'application/json' }

          patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: update_params })
          item = Item.find(id)

          expect(response).to be_successful
          expect(item.name).to_not eq(previous_name)
          expect(item.name).to eq('Silver necklace')
        end

        it 'can update multiple peices of item information' do
          id = create(:item).id
          previous_info = Item.last

          update_params = {
            name: 'Silver necklace',
            unit_price: 10.50
          }
          headers = { 'CONTENT_TYPE' => 'application/json' }

          patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: update_params })
          item = Item.find(id)

          expect(response).to be_successful
          expect(item.name).to_not eq(previous_info.name)
          expect(item.name).to eq('Silver necklace')
          expect(item.unit_price).to_not eq(previous_info.unit_price)
          expect(item.unit_price).to eq(10.50)
        end

        it "can update all attributes of an item's information" do
          item_id = create(:item).id
          merchant_id = create(:merchant).id
          previous_info = Item.last

          update_params = {
            name: 'Silver necklace',
            description: '18 inch brushed silver necklace chain with pendent',
            unit_price: 10.50,
            merchant_id: merchant_id
          }
          headers = { 'CONTENT_TYPE' => 'application/json' }

          patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({ item: update_params })
          item = Item.find(item_id)

          expect(response).to be_successful
          expect(item.name).to_not eq(previous_info.name)
          expect(item.name).to eq('Silver necklace')

          expect(item.description).to_not eq(previous_info.description)
          expect(item.description).to eq('18 inch brushed silver necklace chain with pendent')

          expect(item.unit_price).to_not eq(previous_info.unit_price)
          expect(item.unit_price).to eq(10.50)

          expect(item.merchant_id).to_not eq(previous_info.merchant_id)
          expect(item.merchant_id).to eq(merchant_id)
        end
      end
    end

    describe 'sad path' do
      it 'returns a 404 status code and a empty item hash when an invalid item id is provided for an item' do
        create(:item)
        merchant_id = create(:merchant).id
        previous_info = Item.last

        update_params = {
          name: 'Silver necklace',
          description: '18 inch brushed silver necklace chain with pendent',
          unit_price: 10.50,
          merchant_id: merchant_id
          }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        patch "/api/v1/items/2", headers: headers, params: JSON.generate({ item: update_params })

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)
        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end

      it 'returns a 400 status code and original item info if invalid info is provided for an item' do
        item_id = create(:item).id
        merchant_id = create(:merchant).id
        previous_info = Item.last

        update_params = {
          name: 'Silver necklace',
          description: '',
          unit_price: 10.50,
          merchant_id: merchant_id
          }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({ item: update_params })

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(item[:data][:attributes][:name]).to eq(previous_info.name)
        expect(item[:data][:attributes][:name]).to_not eq('Silver necklace')

        expect(item[:data][:attributes][:description]).to eq(previous_info.description)
        expect(item[:data][:attributes][:description]).to_not eq('')

        expect(item[:data][:attributes][:unit_price]).to eq(previous_info.unit_price)
        expect(item[:data][:attributes][:unit_price]).to_not eq(10.50)

        expect(item[:data][:attributes][:merchant_id]).to eq(previous_info.merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to_not eq(merchant_id)

      end

      it 'returns a 400 status code and a original item hash when an invalid merchant id is provided when creating a item' do
        item_id = create(:item).id
        merchant_id = create(:merchant).id
        previous_info = Item.last

        update_params = {
          name: 'Silver necklace',
          description: '18 inch brushed silver necklace chain with pendent',
          unit_price: 10.50,
          merchant_id: 20
          }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({ item: update_params })
          
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(item[:data][:attributes][:name]).to eq(previous_info.name)
        expect(item[:data][:attributes][:name]).to_not eq('Silver necklace')

        expect(item[:data][:attributes][:description]).to eq(previous_info.description)
        expect(item[:data][:attributes][:description]).to_not eq('')

        expect(item[:data][:attributes][:unit_price]).to eq(previous_info.unit_price)
        expect(item[:data][:attributes][:unit_price]).to_not eq(10.50)

        expect(item[:data][:attributes][:merchant_id]).to eq(previous_info.merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to_not eq(merchant_id)
      end
    end
  end

  describe 'item merchant' do
    describe 'happy path' do
      it 'gets the merchant data for a given item' do
        id = create(:item).id

        get "/api/v1/items/#{id}/merchant"

        item_merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item_merchant).to have_key(:data)
        expect(item_merchant[:data]).to be_a(Hash)

        expect(item_merchant[:data]).to have_key(:id)
        expect(item_merchant[:data][:id]).to be_a(String)

        expect(item_merchant[:data]).to have_key(:type)
        expect(item_merchant[:data][:type]).to be_a(String)

        expect(item_merchant[:data]).to have_key(:attributes)
        expect(item_merchant[:data][:attributes]).to be_a(Hash)

        expect(item_merchant[:data][:attributes]).to have_key(:name)
        expect(item_merchant[:data][:attributes][:name]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'returns a empty items merchant data hash when a invalid item id is requested' do
        get '/api/v1/items/1/merchant'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(item).to have_key(:status)
        expect(item[:status]).to be_a(String)

        expect(item).to have_key(:error)
        expect(item[:error]).to be_a(Hash)

        expect(item[:error]).to have_key(:id)
        expect(item[:error][:id]).to be(nil)

        expect(item[:error]).to have_key(:type)
        expect(item[:error][:type]).to be_a(String)
      end
    end
  end
end
