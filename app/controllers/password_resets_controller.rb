class PasswordResetsController < ApplicationController
  def new

  end

  def create
 
   @user = User.find_by(email: params[:email])


   if @user.present?
     #send Email
     # we have generate mailer for this

     PasswordMailer.with(user: @user).reset.deliver_later # we can also use "deliver_now" here to send email right now

     # Above line says go to the password Mailer, you want sent a reset Email with the user and we have use deliver_later
     # to send this email out in background job.The reason we have use background job to send this is that sending an
     # email can take a little bit of time to connect the email server to send the email.

   else
    redirect_to root_path, notice: "If an account with that emai. was found , we have setn a link to reset your password"
   end
  end
end
