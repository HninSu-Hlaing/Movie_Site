class PasswordResetsController < ApplicationController
  
  def new
    
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # send email
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to login_path , notice: "Please check your email, we will send a link to reset your password"
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, notice: "Your token has expired. Please try again"
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to login_path, notice: "Your password was reset successfully"
    else
      render :edit
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end