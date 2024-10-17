require "rails_helper"

RSpec.describe LoginController, type: :controller do

    context "login successfully" do
      before {Admin.create!(name:'test', mobile:'123', password:'123')}
        it do
            post :create, params: { :name => 'test', :password => '123' }
            
            expect(response).to redirect_to(pages_url)
            expect(flash[:notice]).to eq('Login Successfully')
        end
    end 

    context "login failed" do
        it do
            post :create, params: { :name => 'test', :password => '1234' }

            expect(response).to redirect_to(login_url)
            expect(flash[:notice]).to eq('Invalid username or password')
        end
    end 
        
    it "successfully logged out" do
        delete :destroy

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Logged out successfully')
    end
 
end 

