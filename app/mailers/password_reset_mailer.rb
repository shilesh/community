class PasswordResetMailer < ApplicationMailer

    def reset 
        params[:user]

        mail to: params[:user].email
    end
end
