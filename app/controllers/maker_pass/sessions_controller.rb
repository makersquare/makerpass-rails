module MakerPass
  class SessionsController < ApplicationController
    def create
      auth_hash = request.env['omniauth.auth']

      user = User.find_or_create_by_auth_hash(auth_hash)
      session[:user_id] = user.id

      redirect_to (session.delete(:return_to) || main_app.root_path)
    end

    def destroy
      reset_session
      redirect_to root_path
    end
  end
end
