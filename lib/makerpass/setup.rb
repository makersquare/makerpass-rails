require "makerpass/rails/controller"
require "makerpass/rails/model/authable"

module MakerPass
  module Setup
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def make_authable(model)
        model.extend(Rails::Model::Authable)
        Rails::Controller.setup_helpers(self, model)
      end
    end
  end
end