require "rails_helper"

RSpec.describe LoginController, type: :request do

    context "login successfully" do
    before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it {
            post login_url(:name => 'test', :password => '123')
            
            expect(response).to redirect_to(pages_url)
            expect(flash[:notice]).to eq('Login Successfully')
        }
    end 

    context "login failed" do
    # before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it {
            post login_url(:name => 'test', :password => '234')

            expect(response).to redirect_to(root_url)
            expect(flash[:notice]).to eq('Invalid username or password')
        }
    end 

end 

