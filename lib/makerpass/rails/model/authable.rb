module MakerPass::Rails
  module Model
    module Authable

      def find_or_create_by_auth_hash(auth)
        model = self.find_or_create_by(uid: auth['uid'])

        model.name = auth['info']['name']
        model.email = auth['info']['email']
        model.avatar_url = auth['info']['avatar_url']
        model.save if model.changed?

        model
      end

    end
  end
end