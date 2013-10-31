class UserSessionController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    @user_session = UserSession.new(@user)

    if @user_session.save
      current_user_session = @user_session
      current_user = @user_session.user
      redirect_to '/'
    else
      render text: @user_session.errors
    end
  end

  def destroy
    reset_session
    current_user_session.destroy if current_user_session.present?
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
