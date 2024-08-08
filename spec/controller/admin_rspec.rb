require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:attributes) do
    { name: "Admin Name", mobile: "1234567890", password_digest: "password_digest" }
  end

  describe "GET #index" do
    it "returns a success response with HTML format" do
      Admin.create!(attributes)
      get :index
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      Admin.create!(attributes)
      get :index, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
    end
  end

  describe "GET #show" do
    it "returns a success response with HTML format" do
      admin = Admin.create!(attributes)
      get :show, params: { id: admin.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      admin = Admin.create!(attributes)
      get :show, params: { id: admin.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(admin.id)
      expect(json_response['name']).to eq(admin.name)
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
      expect(json_response['name']).to be_nil
    end
  end

  describe "GET #edit" do
    it "returns a success response with HTML format" do
      admin = Admin.create!(attributes)
      get :edit, params: { id: admin.id }
      expect(response).to be_successful
    end

    it "returns a success response with JSON format" do
      admin = Admin.create!(attributes)
      get :edit, params: { id: admin.id }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
    end
  end

  describe "POST #create" do
    it "creates a new Admin and returns JSON response" do
      post :create, params: { admin: attributes }, format: :json
      expect(response).to be_successful
      expect(response.content_type.split(';').first).to eq("application/json")
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq("Admin Name")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin and returns no content response" do
      admin = Admin.create!(attributes)
      delete :destroy, params: { id: admin.id }, format: :json
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end
end
