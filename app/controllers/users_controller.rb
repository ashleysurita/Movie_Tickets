class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.find_by(:username => params[:username])
    if @user
        redirect '/login'
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
