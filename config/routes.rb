Rails.application.routes.draw do
  resources :books do 
    collection do
      post :add_tags
    end
  end

  root "books#index"
end
