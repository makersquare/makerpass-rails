MakerPass::Engine.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/sessions' => 'sessions#destroy'
end
