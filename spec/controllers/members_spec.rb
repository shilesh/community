# require 'rails_helper'

# RSpec.describe MembersController, type: :controller do

#     it "returns a success response" do
#         get :index
#         expect(response).to be_successful
#     end

#     it "returns a success response" do
#         member = Member.create!(name: 'Test', mobile: '568', blood_group: 'A')
#         get :show, params:{id: member.id}
#         expect(response).to be_successful
#     end

#     it "invalid name members" do
#         member = Member.new(name: nil, mobile: '568', blood_group: 'A')
#         get :index
#         expect(member).to_not be_valid
#     end
    
#     it "invalid mobile members" do
#         member = Member.new(name: 'test', mobile: nil, blood_group: 'A')
#         get :index
#         expect(member).to_not be_valid
#     end
    
#     it "invalid bloodgroup members" do
#         member = Member.new(name: 'test', mobile: '568', blood_group: nil)
#         get :index
#         expect(member).to be_valid
#     end
    
#     it "create members" do
#         member = Member.create!(name: 'Test', mobile: '568', blood_group: 'A')
#         get :index
#         expect(response).to be_successful
#     end

#     it "update member success" do
#         member = Member.create!(name: 'Test', mobile: '568', blood_group: 'A')
#         patch :update, params: { id: member.id, member: { name: 'ss' } }
#         # expect(response).to be_valid
#         expect(response).to redirect_to(member)
#     end

#     it "update member failure" do
#         member = Member.create!(name: 'Test', mobile: '568', blood_group: 'A')
#         patch :update, params: { id: member.id, member: { name: nil } }
    
#         # expect(response).to render_template(:edit)
#         expect(response).to have_http_status(:unprocessable_entity)
#     end

#     it "delete member successfully" do
#         member = Member.create!(name: 'Test', mobile: '568', blood_group: 'A')
#         delete :destroy, params:{id: member.id}

#         expect(response).to redirect_to(members_url)
#         expect(flash[:notice]).to eq('Member was successfully destroyed.')
#         expect(response).to have_http_status(:see_other)
#     end

# end


