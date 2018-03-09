class AuthSessionsController < ApplicationController
  def create
  	user = User.from_omniauth(env['omniauth.auth'])
  	sign_in(user)
  	redirect_to root_path
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
