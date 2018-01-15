Rails.application.routes.draw do
  resources :images do
    collection do
      get  'small/:id' => 'images#small', as: 'small'
      get  'medium/:id' => 'images#medium', as: 'medium'
      get  'large/:id' => 'images#large', as: 'large'
    end
  end
end
