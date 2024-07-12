class LoginController < ApplicationController

    def create
        user =  Admin.find_by(name: login_params[:name])

        if user && user.authenticate(login_params[:password])
            session[:user_id] = user.id
            render json: {token:session.id}
        else 
    
        end 
    end 


    private

    def login_params
        params.permit(:name, :password)
    end
end
