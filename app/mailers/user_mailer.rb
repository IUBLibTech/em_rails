class UserMailer < ApplicationMailer

  def email_password_reset
    @user = params[:user]
    base_url = params[:base_url]
    @url = "#{base_url}#{Rails.application.routes.url_helpers.reset_path(@user.password_reset_key)}"
    mail(to: @user.email, subject: 'Ethnomusicology Multimedia - Password Reset', from: Rails.application.credentials[:email_address])
  end

  def email_account_activation
    @user = params[:user]
    base_url = params[:base_url]
    @url = "#{base_url}#{Rails.application.routes.url_helpers.activate_path(@user.account_activation_key)}"
    mail(to: @user.email, subject: 'Ethnomusicology Multimedia - Account Activation', from: Rails.application.credentials[:email_address])
  end
end
