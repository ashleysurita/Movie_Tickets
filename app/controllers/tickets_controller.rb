class TicketsController < ApplicationController

  # GET: /tickets
  get "/tickets" do
    erb :"/tickets/index.html"
  end

  # GET: /tickets/new
  get "/tickets/new" do
    erb :"/tickets/new.html"
  end

  # POST: /tickets
  post "/tickets" do
    redirect "/tickets"
  end

  # GET: /tickets/5
  get "/tickets/:id" do
    erb :"/tickets/show.html"
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
