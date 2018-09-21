class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to request.referrer
    else
      flash[:danger] = t '.invalid_email'
      render 'new'
    end  
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
