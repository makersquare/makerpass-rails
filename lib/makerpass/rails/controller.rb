module MakerPass::Rails
  module Controller
    def self.setup_helpers(controller, model)
      model_name = model.name.downcase
      session_key = "#{model_name}_id"

      controller.class_eval %Q{
        def current_#{model_name}
          if session[:#{session_key}]
            @current_#{model_name} ||= #{model}.find_by(id: session[:#{session_key}])
            session.delete(:#{session_key}) if @current_#{model_name}.nil?
          end
          @current_#{model_name}
        end

        def authenticate_#{model_name}!
          if current_#{model_name}.nil?
            session[:return_to] = request.fullpath
            redirect_to root_path
          end
        end
      }

      controller.helper_method "current_#{model_name}".to_sym
    end
  end
end