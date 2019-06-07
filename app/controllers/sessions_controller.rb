class SessionsController < ApplicationController
    def new
    end
   # Log the user in and redirect to the user's show page.
  def create
     user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      
      redirect_back_or user

     # Create an error message
    else
        flash.now[:danger] = 'Invalid email or password!'

     
    render 'new'
    end
  end
  
  #Log the user out then redirect to index
  def destroy
    log_out if logged_in?
    
    redirect_to root_url
  end
end
