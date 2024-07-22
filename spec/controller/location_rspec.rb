require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

    it "returns a success response" do
        get :index
        expect(response).to be_successful
    end
 
    it "returns a success response" do
        loc = Location.create!(member_id: 1, lat: '', lng: '')
        get :show, params:{id: loc.id}
        expect(response).to be_successful
    end

    it "New location" do
        loc = Location.new(member_id: 1, lat: '568', lng: 'A')
        get :index
        expect(loc).to be_valid
    end

    it "create location" do
        loc = Location.create!(member_id: 1, lat: '568', lng: 'A')
        get :index
        expect(response).to be_successful
    end

    it "delete location successfully" do
        loc = Location.create!(member_id: 1, lat: '568', lng: 'A')
        delete :destroy, params:{id: loc.id}
        expect(response).to redirect_to(locations_url) #locations_url
    end

end 