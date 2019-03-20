class TicketsController < ApplicationController

  get "/tickets" do
    @user = User.find(session[:user_id])
    @tickets = current_user.tickets #current_user.tickets (show tickets by that user)
    erb :"/tickets/index"
  end

  get "/tickets/new" do
    if logged_in?
      erb :"/tickets/new"
    else
      redirect '/welcome'
    end
  end

  post "/tickets" do
    if Ticket.find_by(:movie_name => params[:movie_name], :date => params[:date], :movie_theater => params[:movie_theater])
      redirect "/tickets"
    else
      ticket = Ticket.new(params)
      ticket.user_id = session[:user_id]
      ticket.save
      redirect '/tickets/:id/'
    end
  end

  get "/tickets/:id" do #seeing single ticket by their id
    erb :"/tickets/show"
  end

  # GET: /tickets/5/edit
  get "/tickets/:id/edit" do
    erb :"/tickets/edit.html"
  end

  # PATCH: /tickets/5
  patch "/tickets/:id" do
    redirect "/tickets/:id"
  end

  # DELETE: /tickets/5/delete
  delete "/tickets/:id/delete" do
    redirect "/tickets"
  end
end
