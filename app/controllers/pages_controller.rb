class PagesController < ApplicationController
 
   
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if  user.present? && user.authenticate(params[:password]) # This  user Authenticate method comes fron has_secured_password from user model(user.rb)
        session[:user_id] = user.id     
        redirect_to members_path, notice: "Logged in Successfully"  # Here we redirected to members page ater successfully
        
        else
            flash.alert = "Invalid email or Password"
            render :home 
        end
    end
   
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out Successfully"
    end

end
