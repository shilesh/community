class LoginController < ApplicationController
    def new 
    end 

    def create
        user =  Admin.find_by(name: login_params[:name])

        respond_to do |format|
            if user && user.authenticate(login_params[:password])
            
                session[:user_id] = user.id
                
                format.html {redirect_to pages_path, notice: "Login Successfully"}
                format.json  {render json: {message: "Login Successfully"}, status: :ok }
            else 
                format.html {redirect_to login_path, notice: "Invalid username or password"}
                format.json  {render json: {message: "Invalid username or password"}, status: :unauthorized} 
            end 
        end
    end 

    def destroy 
        session[:user_id] = nil

        respond_to do |format|
            format.html {redirect_to root_path, notice: "Logged out successfully"}
            format.json  {render json: {message: "Logged out successfully"}} 
        end
    end 

    private

    def login_params
        params.permit(:name, :password)
    end

end