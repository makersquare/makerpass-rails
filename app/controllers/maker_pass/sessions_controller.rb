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
      if session[:return_to]
        session.delete(:return_to)
      elsif main_app.respond_to? path
        main_app.public_send(path)
      elsif main_app.respond_to? :root_path
        main_app.root_path
      else
        "/"
      end
    end

  end
end
