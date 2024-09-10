require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:attributes) do
    { member_id: 4, permanent: true, communication: false, permanent_zip: 'bangalore, sanjaynagar', communication_zip: 'Bangalore' }
  end
  let(:valid_attributes) { { member_id: 4, permanent: true, communication: false, permanent_zip: 'bangalore, sanjaynagar', communication_zip: 'Bangalore' } }
  let(:invalid_attributes) { { member_id: nil, permanent: nil, communication: nil, permanent_zip: '', communication_zip: '' } }

  context "GET #index" do
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

  describe "GET #new" do
  it "returns a success response with HTML format" do
    get :new
    expect(response).to be_successful
    expect(response.content_type.split(';').first).to eq("text/html")
  end

  it "returns a success response with JSON format" do
    get :new, format: :json
    expect(response).to be_successful
    expect(response.content_type.split(';').first).to eq("application/json")
    # Optional: You can check the content of the JSON response here if needed
    # expect(JSON.parse(response.body)).to include('id' => nil)
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
    context "with valid parameters" do
      it "creates a new address and redirects with HTML format" do
        expect {
          post :create, params: { address: valid_attributes }
        }.to change(Address, :count).by(1)
        expect(response).to redirect_to(Address.last)
        expect(flash[:notice]).to eq("Address was successfully created.")
      end

      it "creates a new address and returns JSON with status created" do
        post :create, params: { address: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type.split(';').first).to eq("application/json")
        json_response = JSON.parse(response.body)
        expect(json_response['member_id']).to eq(4)
        expect(json_response['permanent']).to be true
        expect(json_response['permanent_zip']).to eq('bangalore, sanjaynagar')
      end
    end

    context "with invalid parameters" do
      it "does not create a new address and renders new with HTML format" do
        expect {
          post :create, params: { address: invalid_attributes }
        }.not_to change(Address, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it "does not create a new address and returns errors in JSON format" do
        post :create, params: { address: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type.split(';').first).to eq("application/json")
        json_response = JSON.parse(response.body)
      end
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

  # describe "PATCH/PUT #update" do
  context "with valid attributes" do
    it "updates the admin and returns a success response in JSON" do
      address = Address.create!(attributes)
      patch :update, params: { id: address.id, address: valid_attributes }, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  context "with invalid attributes" do

    it "fails to update the admin and returns unprocessable_entity response in JSON" do
      address = Address.create!(attributes)
      patch :update, params: { id: address.id, address: invalid_attributes }, format: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

end
