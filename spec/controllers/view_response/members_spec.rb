require 'rails_helper'

RSpec.describe MembersController, type: :controller do

    before do 
        admin = Admin.create!(name:'test', mobile:'123', password:'123')
        session[:user_id] = admin.id
    end
    
    it "returns a success response" do
        get :index
        expect(response).to be_successful
    end

    it "return success for index action in text/html response" do
        get :index

        expect(response.status).to be(200)
        expect(response.content_type).to eq("text/html; charset=utf-8")
    end 

    it "return success for show action in text/html response" do
        member = Member.create!(name: 'Test', mobile: '5688934893', blood_group: 'A+')
        get :show, params:{id: member.id}

        expect(response.status).to be(200)
        expect(response.content_type).to eq("text/html; charset=utf-8")
    end 

    it "returns a success response" do
        member = Member.create!(name: 'Test', mobile: '5687943274', blood_group: 'A+')
        get :show, params:{id: member.id}
        expect(response).to be_successful
    end

    it "GET new action" do
      get :new

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end

    it "GET edit action" do
      member = Member.create!(name: 'Test', mobile: '5696334893', blood_group: 'A+')
      get :edit, params: { id: member.id }

      expect(response).to have_http_status(:ok)
    end

    it "create action in text/html response" do
        member = Member.create!(name: 'Test', mobile: '5682334893', blood_group: 'A+')
        post :create

        expect(response.content_type).to eq("text/html; charset=utf-8")
    end 


    it "invalid name members" do
        member = Member.new(name: nil, mobile: '568', blood_group: 'A')
        get :index
        expect(member).to_not be_valid
    end
    
    it "invalid mobile members" do
        member = Member.new(name: 'test', mobile: nil, blood_group: 'A')
        get :index
        expect(member).to_not be_valid
    end
    
    it "invalid bloodgroup members" do
        member = Member.new(name: 'test', mobile: '5673974358', blood_group: nil)
        get :index
        expect(member).to_not be_valid
    end

    context "with invalid attributes" do
        let(:invalid_attributes) { { name: 'Te', mobile: '123', blood_group: 'invalid' } }

        it "failed to create action in text/html response" do
            post :create, params: { member: invalid_attributes }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to eq("text/html; charset=utf-8")
        end 
    end
    
    it "create members" do
        member = Member.create!(name: 'Test', mobile: '5687423828', blood_group: 'b-')
        get :index
        expect(response).to be_successful
    end

    it "update member success" do
        member = Member.create!(name: 'Test', mobile: '5783473468', blood_group: 'f+')
        patch :update, params: { id: member.id, member: { name: 'sds' } }
        
        expect(response).to redirect_to(member)
    end

    it "update member in text/html format suceessfully" do
        member = Member.create!(name: 'Test5', mobile: '5698749248', blood_group: 'A-')
        patch :update, params: { id: member.id, member: { name: 'sst' } }
       
        expect(response).to redirect_to(member)
        expect(response.content_type).to eq("text/html; charset=utf-8")
    end

    it "update member failure" do
        member = Member.create!(name: 'Test', mobile: '5689430234', blood_group: 'g+')
        patch :update, params: { id: member.id, member: { name: nil } }
    
        expect(response).to have_http_status(:unprocessable_entity)
    end

    context "failed to update invalid attributes" do
        let(:member) { Member.create!(name: 'ValidName', mobile: '1234567890', blood_group: 'A+') }
        let(:invalid_attributes) { { name: 'Te', mobile: '123', blood_group: 'invalid' } }

        it "returns unprocessable_entity for update action in text/html response" do
            patch :update, params: { id: member.id, member: invalid_attributes }
  
            expect(response).to have_http_status(:unprocessable_entity) 
            expect(response.content_type).to eq("text/html; charset=utf-8")
        end
    end

    it "delete member successfully" do
        member = Member.create!(name: 'Test', mobile: '5673972348', blood_group: 's+')
        delete :destroy, params:{id: member.id}

        expect(response).to redirect_to(members_url)
        expect(flash[:notice]).to eq('Member was successfully destroyed.')
        expect(response).to have_http_status(:see_other)
    end

    it "delete member successfully" do
        member = Member.create!(name: 'Test6', mobile: '5698348348', blood_group: 'hg+')
        delete :destroy, params:{id: member.id}

        expect(response).to redirect_to(members_url)
        expect(flash[:notice]).to eq('Member was successfully destroyed.')
        expect(response.content_type).to eq("text/html; charset=utf-8")
    end

end


