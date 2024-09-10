require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:valid_attributes) do
    { member_id: 4, lat: 40.7128, lng: -74.0060 }
  end
  let(:invalid_attributes) { { member_id: nil, lat: nil, lng: nil } }

  before do 
    admin = Admin.create!(name:'test', mobile:'123', password:'123')
    session[:user_id] = admin.id
  end

  describe "GET #index" do
    let!(:location) { Location.create!(valid_attributes) } 

    it "returns a success response with HTML format" do
      get :index
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      get :index, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(response.body).to include("4")
    end
  end

  describe "GET #show" do
    let!(:location) { Location.create!(valid_attributes) }

    it "returns a success response with HTML format" do
      get :show, params: { id: location.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      get :show, params: { id: location.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(location.id)
      expect(json_response['member_id']).to eq(location.member_id)
    end
  end

  describe "GET #new" do
    it "returns a success response with HTML format" do
      get :new
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      get :new, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response).to include('member_id', 'lat', 'lng')
    end
  end

  describe "GET #edit" do
    let!(:location) { Location.create!(valid_attributes) }

    it "returns a success response with HTML format" do
      get :edit, params: { id: location.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      get :edit, params: { id: location.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(location.id)
    end
  end

  describe "POST #create" do
    it "creates a new Location and returns a success response with JSON format" do
      post :create, params: { location: valid_attributes }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['member_id']).to eq(valid_attributes[:member_id])
    end
  end

  describe "DELETE #destroy" do
    let!(:location) { Location.create!(valid_attributes) }

    it "destroys the requested location and returns no content response" do
      delete :destroy, params: { id: location.id }, format: :json
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end

  # describe "PATCH/PUT #update" do
  context "with valid attributes" do
    it "updates the admin and returns a success response in JSON" do
      location = Location.create!(valid_attributes)
      patch :update, params: { id: location.id, location: valid_attributes }, format: :json


      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  context "with invalid attributes" do

    it "fails to update the admin and returns unprocessable_entity response in JSON" do
      location = Location.create!(valid_attributes)
      patch :update, params: { id: location.id, location: invalid_attributes }, format: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end
end
