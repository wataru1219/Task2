Rails.application.routes.draw do
  #resources :booksでルーディングを自動で作成してくれる
  root to: "homes#top"
  #get '/' => "homes#top", as: :root
  resources :books , only: [:index, :create, :show, :edit, :update, :destroy]

  #同じHTTPメソッドには同じURL名を指定してはいけない。HTTPメソッドが異なっていれば同じでもいい。
  # get 'books/new'
  # get 'top' => 'books#top'
  # post 'books' => 'books#create'
  # get 'books' => 'books#index'
  # get 'books/:id' => 'books#show', as: 'book'
  # get 'books/:id/edit' => 'books#edit', as: 'edit_book'
  # patch 'books/:id' => 'books#update', as: 'update_book'
  # delete 'books/:id' => 'books#destroy', as: 'destroy_book'

end