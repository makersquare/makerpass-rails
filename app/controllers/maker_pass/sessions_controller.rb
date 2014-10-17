module MakerPass
  class SessionsController < ApplicationController
    def create
      auth_hash = request.env['omniauth.auth']

      user = User.find_or_create_by_auth_hash(auth_hash)
      session[:user_id] = user.id

      redirect_to find_redirect_path(:after_sign_in_path)
    end

    def destroy
      reset_session
      redirect_to find_redirect_path(:after_sign_out_path)
    end

    def find_redirect_path(path)
      root = main_app.respond_to?(:root_path) ? main_app.root_path : "/"

      session[:return_to] || self.public_send(path) || root
    end

  end
end
