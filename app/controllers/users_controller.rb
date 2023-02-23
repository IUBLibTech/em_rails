class UsersController < ApplicationController
  #before_action :set_user, only: %i[ show edit update destroy ]

  def activation
    render 'activation'
  end
  def activate
    @user = User.find_by(account_activation_key: params[:key])
    if @user && !@user.account_activated
      @user.update(account_activated: true)
      flash[:notice] = "You have successfully activated your account. You can now login."
      redirect_to signin_path
    elsif @user && @user.account_activated
      flash[:notice] = "This account has already been activated."
      redirect_to signin_path
    else
      flash[:notice] = "No account was found with that activation code. Please enter your email address and a new activation code will be emailed to you."
      redirect_to reactivation_path
    end
  end
  def reactivation
    @user = User.new
    render 'users/reactivation'
  end
  def reactivate
    @user = User.find_by(email: params[:user][:email])
    if @user && !@user.account_activated
      send_activation_email(@user)
      flash.now[:notice] = "You should receive an email detailing how to activate you account shortly"
    elsif @user && @user.account_activated
      flash.now[:notice] = "This account has already been activated."
    else
      flash.now[:notice] = "No account with that email address could be found."
    end
  end

  # displays the form to request password reset or handles the POST request to do so
  def reset_password
    if request.get?
      @user = User.new
      render 'users/password_reset_show'
    elsif request.post?
      @user = User.find_by(email: params[:user][:email])
      if @user.nil?
        flash[:html_safe] = true
        flash[:warning] = "An account with the email address could not be found."
        redirect_to request_reset_path
      else
        now = DateTime.now
        key = BCrypt::Engine.hash_secret("#{now.to_s}_#{@user.email}", BCrypt::Engine.generate_salt)
        @user.update!(password_reset_key: key, password_reset_key_timestamp: now)
        # using deliver_now because there is no Job adapter for this application
        UserMailer.with(user: @user, base_url: request.base_url).email_password_reset.deliver_now
        render "users/password_reset_requested"
      end
    end
  end

  # processes the emailed link sent to users to reset a password
  def reset
    if request.get?
      key = params[:key]
      @user = User.where(password_reset_key: key).first
      # the reset key is valid for 24 hrs after requesting a reset
      if (DateTime.now.to_i - @user.password_reset_key_timestamp.to_i) < (24.hours / 1.seconds)
        render 'users/reset'
      else
        flash[:notice] = "Your request has expired. Please re-request a password reset and complete the instructions within 24 hrs."
        redirect_to request_reset_path, method: :get
      end
    elsif request.post?
      @user = User.find(params[:id])
      saved = @user.update(user_params)
      if saved
        flash[:notice] = "You have successfully reset your password."
        redirect_to signin_path
      else
        render "users/reset"
      end
    else
      redirect_to root_path
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    render 'users/new'
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    # create an activation code and attach to the new user
    @user.account_activation_key = SecureRandom.urlsafe_base64(64, false)
    if @user.save
      UserMailer.with(user: @user, base_url: request.base_url).email_account_activation.deliver_now
      redirect_to activation_path
    else
      render 'users/new'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :agreed_to_eula, :password, :password_confirmation, :password_converted)
    end
end
