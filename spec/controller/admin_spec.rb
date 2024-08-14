# require 'rails_helper'

# RSpec.describe AdminsController, type: :controller do
#   let(:attributes) do
#     {id: 4, name: "Admin Name", mobile: "1234567890", password_digest: "password_digest" }
#   end

#   # describe "GET #index" do
#   #   it "returns a success response with HTML format" do
#   #     Admin.create!(name: "Admin Name", mobile: "1234567890", password_digest: "password_digest")
#   #     get :index
#   #     expect(response).to be_successful
#   #   end

#   #   it "returns a success response with JSON format" do
#   #     Admin.create!(name: "Admin Name", mobile: "1234567891", password_digest: "password_digest")
#   #     get :index, format: :json
#   #     expect(response).to be_successful
#   #     expect(response.body).to include("Admin Name")  
#   #      expect(response.content_type.split(';').first).to eq("application/json")
#   #   end
#   # end

#   describe "GET #show" do
#     it "returns a success response with HTML format" do
#       admin = Admin.create!(name: "Admin Name", mobile: "1234567892", password_digest: "password_digest")
#       get :show, params: { id: 4}
#       expect(response).to be_successful
#     end

#     it "returns a success response with JSON format" do
#       admin = Admin.create!(name: "Admin Name", mobile: "1234567893", password_digest: "password_digest")
#       get :show, params: { id: admin.id }, format: :json
#       expect(response).to be_successful
#       expect(response.content_type.split(';').first).to eq("application/json")
#       json_response = JSON.parse(response.body)
#       expect(json_response['id']).to eq(admin.id)
#       expect(json_response['name']).to eq(admin.name)
#       expect(response.body).to include("Admin Name")
#     end
#   end

#   describe "GET #new" do
#     it "returns a success response with HTML format" do
#       get :new
#       expect(response).to be_successful
#     end

#     it "returns a success response with JSON format" do
#       get :new, format: :json
#       expect(response).to be_successful
#       expect(response.content_type.split(';').first).to eq("application/json")
#       json_response = JSON.parse(response.body)
#       expect(json_response['name']).to be_nil
#     end
#   end

#   describe "GET #edit" do
#     it "returns a success response with HTML format" do
#       admin = Admin.create!(name: "Admin Name", mobile: "1234567894", password_digest: "password_digest")
#       get :edit, params: { id: admin.id }
#       expect(response).to be_successful
#     end

#     it "returns a success response with JSON format" do
#       admin = Admin.create!(name: "Admin Name", mobile: "1234567895", password_digest: "password_digest")
#       get :edit, params: { id: admin.id }, format: :json
#       expect(response).to be_successful
#       expect(response.content_type.split(';').first).to eq("application/json")
#       expect(response.body).to include("Admin Name")
#     end
#   end

#   describe "POST #create" do
#     it "creates a new Admin and returns JSON response" do
#       post :create, params: { admin: {name: "Admin Name", mobile: "1234567896", password_digest: "password_digest"} }, format: :json
#       expect(response).to be_successful
#       expect(response.content_type.split(';').first).to eq("application/json")
#       json_response = JSON.parse(response.body)
#       expect(json_response['name']).to eq("Admin Name")
#     end
#   end

#   describe "DELETE #destroy" do
#     it "destroys the requested admin and returns no content response" do
#       admin = Admin.create!(name: "Admin Name", mobile: "1234567897", password_digest: "password_digest")
#       delete :destroy, params: { id: admin.id }, format: :json
#       expect(response).to have_http_status(:no_content)
#       expect(response.body).to be_empty
#     end
#   end
# end


require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:admin) { Admin.create!(name: 'Test Admin', mobile: '5551234567', password: 'securepassword') }

  # describe "GET #show" do
  #   it "returns a success response in JSON" do
  #     get :show, params: { id: admin.id }, format: :json

  #     expect(response).to have_http_status(:ok)
  #     expect(response.content_type).to eq("application/json; charset=utf-8")
  #     expect(response.body).to include("5551234567")
  #   end
  # end

  describe "GET #show" do
    it "returns a success response in JSON" do
      get :show, params: { id: admin.id }, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include("5551234567")
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
