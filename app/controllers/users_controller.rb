class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets/index'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tickets/index'
    end
  end

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


end
