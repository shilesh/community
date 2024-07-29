require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

    it "returns a success response" do
        get :index
        expect(response).to be_successful
    end
 
    it "returns a success response" do
        admin = Admin.create!(name: 'Test4', mobile: '5975475487', password_digest: 'password')
        get :show, params:{id: admin.id}
        expect(response).to be_successful
    end

    it "New Admin" do
        admin = Admin.new(name: 'Test4', mobile: '5975475487', password_digest: 'password')
        get :index
        expect(admin).to be_valid
    end

    it "create Admin" do
        admin = Admin.create!(name: 'Test4', mobile: '5975475487', password_digest: 'password')
        get :index
        expect(response).to be_successful
    end

    it "delete Admin successfully" do
        admin = Admin.create!(name: 'Test4', mobile: '5975475487', password_digest: 'password')
        delete :destroy, params:{id: admin.id}
        expect(response).to redirect_to(admins_url) 
    end

end 