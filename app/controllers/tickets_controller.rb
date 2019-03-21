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
    if params[:movie_name].empty? || params[:date].empty? || params[:movie_theater].empty?
      redirect '/tickets/new'
    elsif Ticket.find_by(:movie_name => params[:movie_name], :date => params[:date], :movie_theater => params[:movie_theater])
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

  patch '/tickets/:id' do #patch route for specific ticket
    if params[:movie_name].empty? || params[:date].empty? || params[:movie_theater].empty?
      redirect "/tickets/#{params[:id]}/edit"
    elsif logged_in?
      @ticket = Ticket.find(params[:id])
      params.delete('_method')
      @ticket.update(params)
      redirect to "/tickets/#{@ticket.id}"
    else
      redirect '/login'
    end
  end


  delete "/tickets/:id" do
    ticket = Ticket.find(params[:id])
    if logged_in? && current_user[:id] == ticket.user_id #check if user is logged_in and if the ticket belongs to user
      ticket.delete
      redirect '/tickets'
    elsif logged_in? #if user is only logged_in but ticket doesn't belong to user
      redirect '/tickets'
    else #if user is not logged in
      redirect "/login"
    end
  end

end
