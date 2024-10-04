require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:admin) { Admin.create!(name: 'Test Admin', mobile: '5551234567', password: 'securepassword') }

  before do
    session[:user_id] = admin.id
  end


  describe "GET #show" do
    it "returns a success response in JSON" do
      get :show, params: { id: admin.id }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end

  describe "GET #new" do
    it "returns a success response in JSON" do
      get :new, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: admin.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_attributes) { { name: 'New Admin', mobile: '5559876543', password: 'newsecurepassword' } }

      it "creates a new admin and returns a success response in JSON" do
        post :create, params: { admin: valid_attributes }, format: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include('New Admin')
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { name: '', mobile: 'invalid', password: 'short' } }

      it "fails to create a new admin and returns unprocessable_entity response in JSON" do
        post :create, params: { admin: invalid_attributes }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the admin and returns a success response in JSON" do
        patch :update, params: { id: admin.id, admin: { name: 'Updated Admin' } }, format: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include('Updated Admin')
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { name: '', mobile: 'invalid', password: 'short' } }

      it "fails to update the admin and returns unprocessable_entity response in JSON" do
        patch :update, params: { id: admin.id, admin: invalid_attributes }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the admin and returns no_content response" do
      delete :destroy, params: { id: admin.id }, format: :json

      expect(response).to have_http_status(:no_content)
      expect(response.content_type).to be_nil # since no content type is set
    end
  end

  describe "POST #change_password" do
    context "with correct old password" do
      it "changes the password successfully and returns a success response" do
        post :change_password, params: { id: admin.id, old_password: 'securepassword', new_password: 'newsecurepassword' }

        expect(response).to redirect_to(admin_path(admin))
        expect(flash[:notice]).to eq("Password changed succcessfully")
      end
    end

    context "with incorrect old password" do
      it "fails to change the password and returns a notice response" do
        post :change_password, params: { id: admin.id, old_password: 'wrongpassword', new_password: 'newsecurepassword' }

        expect(response).to redirect_to(admin_path(admin))
        expect(flash[:notice]).to eq("Failed, Must enter correct Password")
      end
    end
  end
end
