require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do 
    
    controller do
      def index
        authenticate_user!
      end
    end

    context "when user logged in" do 
      before do 
        admin = Admin.create!(name:'test', mobile:'123', password:'123')
        session[:user_id] = admin.id
      end

      it "finding current user" do 
        expect(subject.current_user).to be_valid
      end 
    end

    context "when user is not logged in" do
      before do
        allow(controller).to receive(:current_user).and_return(nil)
        get :index
      end
  
      it "redirects to the login page" do
        expect(response).to redirect_to(new_login_path)
        expect(flash[:notice]).to eq("Please log in")
      end
    end
    
end
