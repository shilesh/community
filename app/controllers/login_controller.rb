class LoginController < ApplicationController
    def new 
    end 

    def create
        user =  Admin.find_by(name: login_params[:name])

        if user && user.authenticate(login_params[:password])
            
            session[:user_id] = user.id
            redirect_to pages_path, notice: "Login Successfully"
        else 
            redirect_to root_path, notice: "Invalid username or password"
        end 
    end 

    def destroy

        session[:user_id] = nil
        
        redirect_to root_path, notice: "Logged out successfully"
    end 

    private

    def login_params
        params.permit(:name, :password)
    end

end