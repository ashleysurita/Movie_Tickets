require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect '/tickets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if empty_form?
      redirect to '/signup'
    elsif User.find_by(username: params[:username])
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tickets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tickets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tickets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Successfully logged out."
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
