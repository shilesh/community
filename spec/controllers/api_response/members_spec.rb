require 'rails_helper'

RSpec.describe MembersController, type: :controller do

    before do 
        admin = Admin.create!(name:'test', mobile:'123', password:'123')
        session[:user_id] = admin.id
    end
    
    it "returns a success for index action in json response" do
        get :index, :format => :json

        expect(response.status).to be(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end


    it "returns a success for show action in json response" do
        member = Member.create!(name: 'Test', mobile: '5664924748', blood_group: 'A+')
        get :show, params:{id: member.id}, :format => :json

        expect(response.status).to be(200)
        expect(response.body).to include("5664924748")
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "GET edit action" do
        member = Member.create!(name: 'Test', mobile: '5696334893', blood_group: 'A+')
        get :edit, params: { id: member.id }, :format => :json
  
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    context "with valid attributes" do
        let(:valid_attributes) { { name: 'Test', mobile: '5688348934', blood_group: 'A+' } }
  
        it "create action in json response" do
            post :create, params: { member: valid_attributes }, :format => :json

            expect(response.status).to be(200)
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end 
    end

    context "with invalid attributes" do
        let(:invalid_attributes) { { name: 'Te', mobile: '123', blood_group: '' } }

        it "failed to create action in application/json response" do
            post :create, params: { member: invalid_attributes }, :format => :json
    
            expect(response).to have_http_status(:unprocessable_entity) 
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end
    end 

    it "update member in application/json format successfully" do
        member = Member.create!(name: 'Test5', mobile: '5694549248', blood_group: 'A-')
        patch :update, params: { id: member.id, member: { name: 'sst' } }, :format => :json
       
        # expect(response).to redirect_to(member)
        expect(response.status).to be(200)
        expect(response.body).to include("5694549248")
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end
    
    context "failed to update invalid attributes" do
        let(:member) { Member.create!(name: 'ValidName', mobile: '1234567890', blood_group: 'A+') }
        let(:invalid_attributes) { { name: 'Te', mobile: '123', blood_group: 'invalid' } }
  
    
        it "returns unprocessable_entity for update action in json response" do
          patch :update, params: { id: member.id, member: invalid_attributes }, :format => :json
  
          expect(response).to have_http_status(:unprocessable_entity) 
          expect(response.content_type).to eq("application/json; charset=utf-8")
        end
    end

    it "delete member successfully" do
        member = Member.create!(name: 'Test6', mobile: '5698348348', blood_group: 'hg+')
        delete :destroy, params:{id: member.id}, :format => :json

        expect(response.message).to eq("OK")
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end

end 