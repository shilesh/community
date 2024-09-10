require "rails_helper"

RSpec.describe LoginController, type: :request do

    context "login successfully" do
      before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it do
            post login_url(:name => 'test', :password => '123')
            
            expect(response).to redirect_to(pages_url)
            expect(flash[:notice]).to eq('Login Successfully')
        end
    end 

    context "login failed" do
        it do 
            post login_url(:name => 'test', :password => '234')

            expect(response).to redirect_to(login_url)
            expect(flash[:notice]).to eq('Invalid username or password')
        end
    end 
        
    it "successfully logged out" do
        delete logout_url()

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Logged out successfully')
    end
 
end 

