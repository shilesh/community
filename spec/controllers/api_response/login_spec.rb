require "rails_helper"

RSpec.describe LoginController, type: :controller do

    context "login successfully" do
    before {Admin.create!(name:'test', mobile:'1231239876', password:'123')}
        it do
            post :create, params: { :name => 'test', :password => '123' }, :format => :json

            expect(response).to have_http_status(200)
            json_response = JSON.parse(response.body)
            expect(json_response["message"]).to eq("Login Successfully")
        end
    end 

    context "login failed" do
        it do
            post :create, params: { :name => 'test', :password => '1234' }, as: :json

            expect(response).to have_http_status(:unauthorized)
            json_response = JSON.parse(response.body)
            expect(json_response["message"]).to eq("Invalid username or password")
        end
    end 

end 

