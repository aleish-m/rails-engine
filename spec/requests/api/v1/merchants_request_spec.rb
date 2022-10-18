require 'rails_helper'

describe "Merchant API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 4)
    
    get 'api/v1/merchants'

    expect(response).to be_successful
  end
end