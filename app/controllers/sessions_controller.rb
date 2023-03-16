class SessionsController < ApplicationController
  before_action :logged_in?, except: [:new, :create]

  def new
    @user = User.new
    render 'users/login'
  end

  # aka login
  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      if @user.account_activated
        session[:user_id] = @user.id
        forward = session[:forward]
        # only clear the forward if the user authenticates - keep it around if they typo their username/password
        session[:forward] = nil
        redirect_to forward || root_path
      else
        flash[:notice] = "You have not activ"
        session[:forward] = nil
        redirect_to reactivation_path
      end
    else
      flash[:warning] = "No account could be found with that email address and/or password."
      redirect_to signin_path
    end
  end

  # aka log out
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to root_path
  end


end
