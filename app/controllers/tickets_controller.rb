class TicketsController < ApplicationController

  get "/tickets" do #ticket homepage
    @user = User.find(session[:user_id])
    @tickets = current_user.tickets
    erb :"/tickets/index"
  end

  get "/tickets/new" do #see form to create new ticket
    if logged_in?
      erb :"/tickets/new"
    else
      redirect '/login'
    end
  end

  post "/tickets" do
    if Ticket.find_by(:movie_name => params[:movie_name], :date => params[:date], :movie_theater => params[:movie_theater])
      redirect "/tickets"
    else
      ticket = Ticket.new(params)
      ticket.user_id = session[:user_id]
      ticket.save
      redirect "/tickets/#{ticket.id}"
    end
  end

  get "/tickets/:id" do #seeing single ticket by their id
    @ticket = Ticket.find(params[:id])
    erb :"/tickets/show"
  end

  get "/tickets/:id/edit" do #edit specific ticket
    if logged_in?
      @ticket = Ticket.find(params[:id])
      erb :"/tickets/edit"
    else
      redirect '/login'
    end
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
