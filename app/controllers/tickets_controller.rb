class TicketsController < ApplicationController

  get "/tickets" do #ticket homepage
    redir
    @tickets = current_user.tickets
    erb :"/tickets/index"
  end

  get "/tickets/new" do #see form to create new ticket
    redir
    erb :"/tickets/new"
  end

  post "/tickets" do
    if empty_form?
      redirect '/tickets/new'
    elsif Ticket.find_by(:movie_name => params[:movie_name], :date => params[:date], :movie_theater => params[:movie_theater])
      redirect "/tickets"
    else
      current_user.tickets.build(params)
      ticket.save
      redirect "/tickets/#{ticket.id}"
    end
  end

  get "/tickets/:id" do #seeing single ticket by their id
      if !Ticket.exists?(params[:id])
        redirect '/tickets'
      elsif logged_in? && current_user.tickets.include?(Ticket.find(params[:id]))
        @ticket = Ticket.find(params[:id])
        erb :"/tickets/show"
      else
        redirect '/tickets'
      end
    end

  get "/tickets/:id/edit" do #edit form for specific ticket
    @ticket = Ticket.find(params[:id])
    if logged_in? && current_user.tickets.include?(@ticket)
      erb :"/tickets/edit"
    elsif logged_in?
      redirect '/tickets'
    else
      redirect '/login'
    end
  end

  patch '/tickets/:id' do #edit route for specific ticket
    @ticket = Ticket.find(params[:id])
    if empty_form?
      redirect "/tickets/#{params[:id]}/edit"
    elsif logged_in? && current_user.id == @ticket.user_id
      params.delete('_method')
      @ticket.update(params)
      redirect to "/tickets/#{@ticket.id}"
    else
      redirect '/login'
    end
  end


  delete "/tickets/:id" do
    ticket = Ticket.find(params[:id])
    if logged_in? && current_user.id == ticket.user_id #check if user is logged_in and if the ticket belongs to user
      ticket.delete
      redirect '/tickets'
    elsif logged_in? #if user is only logged_in but ticket doesn't belong to user
      redirect '/tickets'
    else #if user is not logged in
      redirect "/login"
    end
  end

end
