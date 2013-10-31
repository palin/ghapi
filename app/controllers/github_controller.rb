require 'oauth2'

class GithubController < ApplicationController

  def callback
    client = OAuth2::Client.new(
      '04d962504bcb338048af',
      'f00f0d0475ac6b500459da5bed91b054adb78e4d',
      :site => 'http://localhost:3000',
      :token_url => 'https://github.com/login/oauth/access_token',
      :authorize_url => 'https://github.com/login/oauth/authorize')
    response = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/github/callback/success')
    token = response.token
    type = response.params['token_type']
    if token && type
      @user = User.find_or_create_from_auth_hash(response.get('https://api.github.com/user', :params => { access_token: token }))
      self.current_user = @user
    else
      render :text => "Error occured"
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
