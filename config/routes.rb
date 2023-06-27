Rails.application.routes.draw do

 # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

   scope module: :public do

    root to: 'homes#top'

    get 'about'=>'homes#about'

    resources :items, only: [:index,:show]

    get 'customers/mypage'=>'customers#show'
    get 'customers/information/edit'=>'customers#edit'
    patch 'customers/update'=>'customers#update'
    get 'customers/check'
    patch 'customers/withdraw'

    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index,:update,:create,:destroy]


    resources :orders, only: [:new,:index,:show,:create]

    post 'orders/check'
    get 'orders/thanx'

    resources :addresses, only: [:index,:edit,:create,:update,:destroy]

 end


 # 管理者用
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

    get '/'=>'homes#top'



    resources :items

    resources :genres, only: [:index,:edit,:create,:update,:destroy]

    resources :customers, only: [:index,:show,:edit,:update]

    resources :orders, only: [:show,:update]

    resources :order_details, only: [:update]

   end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
