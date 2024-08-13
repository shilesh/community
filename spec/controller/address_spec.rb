require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:attributes) do
    { member_id: 4, permanent: true, communication: false, permanent_zip: 'bangalore, sanjaynagar', communication_zip: 'Bangalore' }
  end

  describe "GET #index" do
    it "returns a success response with HTML format" do
      get :index
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      Address.create!(attributes)
      get :index, format: :json
      expect(response).to be_successful
      expect(response.body).to include("bangalore, sanjaynagar")  
      expect(response.content_type.split(';').first).to eq("application/json")
    end
  end

  describe "GET #show" do
    it "returns a success response with HTML format" do
      address = Address.create!(attributes)
      get :show, params: { id: address.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      address = Address.create!(attributes)
      get :show, params: { id: address.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(address.id)
      expect(json_response['member_id']).to eq(address.member_id)
      expect(response.body).to include("bangalore, sanjaynagar") 
    end
  end

  describe "GET #edit" do
    it "returns a success response with HTML format" do
      address = Address.create!(attributes)
      get :edit, params: { id: address.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      address = Address.create!(attributes)
      get :edit, params: { id: address.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      expect(response.body).to include("bangalore, sanjaynagar") 
    end
  end

  describe "POST #create" do
    it "creates a valid address and returns JSON response" do
      post :create, params: { address: attributes }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['member_id']).to eq(4)
      expect(json_response['permanent']).to be true
    end
  end

  describe "DELETE #destroy" do
    it "deletes an address successfully and returns no content response" do
      address = Address.create!(attributes)
      delete :destroy, params: { id: address.id }, format: :json
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end
end
