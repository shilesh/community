class PasswordsController < ApplicationController

    before_action :require_user_logged_in!

    #we have define edit and update method in application controller

    def edit
    end

    def update
       if  Current.user.update(password_params)
          redirect_to root_path, notice: "Password Updated"
       else
        render :edit
       end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)

    end


end