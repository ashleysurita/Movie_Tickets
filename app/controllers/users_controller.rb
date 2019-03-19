class UsersController < ApplicationController

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
      @user = User.find_by(:username => params[:username], :password => params[:password])
      if @user
        reidrect '/tickets/index'
      else
        redirect '/login'
      end
    end

    get '/signup' do
      erb :'users/signup'
    end

    post '/signup' do
      # take username and see if it exists in the db
      @user = User.find_by(:username => params[:username])
      #if exists? redirect to login
      if @user
          redirect '/login'
      #if doesnt exist, create a user and redirect to the tickets index page
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tickets/index'
      end
    end

end
