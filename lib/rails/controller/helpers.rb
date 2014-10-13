module MakerPass::Rails
  module Controller
    module Helpers
      class << self
        def setup_for(base)
          authable_name = base.name.downcase
          session_key = "#{authable_name}_id".to_sym

          application_controller = ::ApplicationController

          application_controller.class_eval <<-RUBY
            def current_#{authable_name}
              if session[#{session_key}]
                @current_#{authable_name} ||= #{base}.find_by(id: session[#{session_key}])
                session.delete(#{session_key}) if @current_#{authable_name}.nil?
              end
              @current_#{authable_name}
            end

            def authenticate_#{authable_name}!
              if current_#{authable_name}.nil?
                session[:return_to] = request.fullpath
                redirect_to root_path
              end
            end
          RUBY

          application_controller.helper_method "current_#{authable_name}".to_sym
        end
      end
    end
  end
end