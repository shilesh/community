require 'rails_helper'

RSpec.describe FamilyMembersController, type: :controller do

    before do 
        admin = Admin.create!(name:'test', mobile:'123', password:'123')
        session[:user_id] = admin.id
    end

    it "return success response for index method" do
        get :index
        expect(response).to be_successful
    end 

    it "return success response for show method" do 
        fm1 = FamilyMember.create!(name:'test', mobile:'1184983238', blood_group:'A+')
        get :show, params:{id: fm1.id}
        
        expect(response).to be_successful
    end 

    it "invalid name family_member" do
        fm1 = FamilyMember.new(name:nil, mobile:'11', blood_group:'A')
        get :index
        expect(fm1).to_not be_valid
    end 

    it "invalid mobile family_member" do 
        fm2 = FamilyMember.new(name:'test', mobile:nil, blood_group:'A')
        get :index
        expect(fm2).to_not be_valid
    end 

    it "blood_group is not mandetory" do 
        fm3 = FamilyMember.new(name:'test', mobile:'11', blood_group:nil)
        get :index
        expect(fm3).to_not be_valid
    end 

    it "GET new action" do
        get :new
  
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  
    it "GET edit action" do
        fm = FamilyMember.create!(name: 'Test', mobile: '5696334893', blood_group: 'A+')
        get :edit, params: { id: fm.id }
  
        expect(response).to have_http_status(:ok)
    end

    it "create successfully new family_member" do
        fm = FamilyMember.create!(name:'test', mobile:'2793792732', blood_group:'B-')

        expect(response).to be_successful
    end 

    it "update successfully family_member" do 
        fm3 = FamilyMember.create!(name: 'Test', mobile: '2983489282', blood_group: 'c-')
        patch :update, params: { id: fm3.id, family_member: { name: 'sst' } }
        
        expect(response).to redirect_to(fm3)
    end 

    it "failed to update family_member" do 
        fm3 = FamilyMember.create!(name: 'Test', mobile: '2987479322', blood_group: 'd-')
        patch :update, params: { id: fm3.id, family_member: { name: nil } }
        
        expect(response).to have_http_status(:unprocessable_entity)
    end 

    it "delete family member successfully" do 
        fm = FamilyMember.create!(name: 'Test', mobile: '2984738732', blood_group: 'g-')
        delete :destroy, params:{id: fm.id}

        expect(response).to redirect_to(family_members_url)
        expect(flash[:notice]).to eq("Family member was successfully destroyed.")
        expect(response).to have_http_status(:see_other)
    end 

end