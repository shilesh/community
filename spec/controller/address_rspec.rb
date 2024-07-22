require 'rails_helper'

RSpec.describe AddressesController, type: :controller do

    it "returns a success response" do
        get :index
        expect(response).to be_successful
    end
 
    it "returns a success response" do
        address = Address.create!(member_id: 4, permanent: true, communication:false ,permanent_zip: 'bangalore, sanjaynagar',communication_zip: 'Bangalore')
        get :show, params:{id: address.id}
        expect(response).to be_successful
    end

    it "New Address" do
        address = Address.new(member_id: 4, permanent: true, communication:false ,permanent_zip: 'bangalore, sanjaynagar',communication_zip: 'Bangalore')
        get :index
        expect(address).to be_valid
    end

    it "create Address" do
        address = Address.create!(member_id: 4, permanent: true, communication:false ,permanent_zip: 'bangalore, sanjaynagar',communication_zip: 'Bangalore')
        get :index
        expect(response).to be_successful
    end

    it "delete Address successfully" do
        address = Address.create!(member_id: 4, permanent: true, communication:false ,permanent_zip: 'bangalore, sanjaynagar',communication_zip: 'Bangalore')
        delete :destroy, params:{id: address.id}
        expect(response).to redirect_to(addresses_url) 
    end

end 
