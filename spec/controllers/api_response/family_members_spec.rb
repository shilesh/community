require 'rails_helper'

RSpec.describe FamilyMembersController, type: :controller do

    it "returns a success for index action in json response" do
        get :index, :format => :json

        expect(response.status).to be(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end


    it "returns a success for show action in json response" do
        fm = FamilyMember.create!(name: 'Test', mobile: '5664924748', blood_group: 'A+')
        get :show, params:{id: fm.id}, :format => :json

        expect(response.status).to be(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    context "with valid attributes" do
        let(:valid_attributes) { { name: 'Test', mobile: '5688348934', blood_group: 'A+' } }
  
        it "create action in json response" do
            post :create, params: { family_member: valid_attributes }, :format => :json

            expect(response.status).to be(200)
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end 
    end

    context "with invalid attributes" do
        let(:invalid_attributes) { { name: 'Te', mobile: '123', blood_group: '' } }

        it "failed to create action in application/json response" do
            post :create, params: { family_member: invalid_attributes }, :format => :json
    
            expect(response).to have_http_status(:unprocessable_entity) 
            expect(response.content_type).to eq("application/json; charset=utf-8")
          end
    end


    it "update member in application/json format successfully" do
        fm = FamilyMember.create!(name: 'Test5', mobile: '5694549248', blood_group: 'A-')
        patch :update, params: { id: fm.id, family_member: { name: 'sst' } }, :format => :json
       
        expect(response.status).to be(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end
    
    context "failed to update invalid attributes" do
  
        fm = FamilyMember.create!(name: 'somename', mobile: '1234567890', blood_group: 'A+')

        it "returns unprocessable_entity for update action in json response" do
          patch :update, params: { id: fm.id, family_member: {name:'ts', mobile: '123', blood_group:'A+'} }, :format => :json
  
          expect(response).to have_http_status(:unprocessable_entity) 
          expect(response.content_type).to eq("application/json; charset=utf-8")
        end
    end

    it "delete family member successfully" do
        fm = FamilyMember.create!(name: 'Test6', mobile: '5698348348', blood_group: 'hg+')
        delete :destroy, params:{id: fm.id}, :format => :json

        expect(response.status).to be(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end

end 