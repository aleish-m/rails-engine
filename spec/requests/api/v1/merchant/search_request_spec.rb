require 'rails_helper'

describe 'Merchant Search API' do
  describe 'search index' do
    describe 'happy path' do
      it 'returns a single merchant based on search params' do
        merchant_1 = create(:merchant, name: 'Ring World')
        merchant_2 = create(:merchant, name: 'All the Pretty Rings')

        get '/api/v1/merchants/find?name=ring'

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
      end
    end

    describe 'sad path' do
      it 'returns a 404 status code and a empty merchant hash when no merchant is found' do
        merchant_1 = create(:merchant, name: 'Ring World')
        merchant_2 = create(:merchant, name: 'All the Pretty Rings')

        get '/api/v1/merchants/find?name=silver'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_a(Hash)

        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be(nil)

        expect(merchant[:data]).to have_key(:type)
        expect(merchant[:data][:type]).to be_a(String)

        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes]).to be_a(Hash)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)
      end

      it 'returns a 400 status code and a merchant error hash when name parameter is empty' do
        merchant_1 = create(:merchant, name: 'Ring World')
        merchant_2 = create(:merchant, name: 'All the Pretty Rings')

        get '/api/v1/merchants/find?name='

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(merchant).to have_key(:status)
        expect(merchant[:status]).to be_a(String)

        expect(merchant).to have_key(:error)
        expect(merchant[:error]).to be_a(Hash)

        expect(merchant[:error]).to have_key(:id)
        expect(merchant[:error][:id]).to be(nil)

        expect(merchant[:error]).to have_key(:type)
        expect(merchant[:error][:type]).to be_a(String)
      end

      it 'returns a 400 status code and a merchant error hash when parameter missing' do
        merchant_1 = create(:merchant, name: 'Ring World')
        merchant_2 = create(:merchant, name: 'All the Pretty Rings')

        get '/api/v1/merchants/find?'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

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
end