module MakerPass
  module Authable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def find_or_create_by_auth_hash(auth)
        user = self.find_or_create_by(uid: auth['uid'])

        user.name = auth['info']['name']
        user.email = auth['info']['email']
        user.avatar_url = auth['info']['avatar_url']
        user.save if user.changed?

        user
      end
    end
  end
end