require "rails_helper"

RSpec.describe LoginController, type: :request do

    context "login successfully" do
    before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it {
            post login_url(:name => 'test', :password => '123'), as: :json
            
            expect(response).to have_http_status(200)
            json_response = JSON.parse(response.body)
            expect(json_response["message"]).to eq("Login Successfully")
        }
    end 

    context "login failed" do
    # before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it {
            post login_url(:name => 'test', :password => '234'), as: :json

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Invalid username or password")
        }
    end 

end 

