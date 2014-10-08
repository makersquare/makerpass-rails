puts "YEA"
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :makersquare, ENV['MAKERSQUARE_KEY'], ENV['MAKERSQUARE_SECRET']
end
