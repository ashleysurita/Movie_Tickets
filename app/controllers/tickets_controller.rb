class TicketsController < ApplicationController

  # GET: /tickets
  get "/tickets" do
    erb :"/tickets/index"
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
  get "/tickets/:slug" do
    erb :"/tickets/show"
  end

  # GET: /tickets/5/edit
  get "/tickets/:slug/edit" do
    erb :"/tickets/edit.html"
  end

  # PATCH: /tickets/5
  patch "/tickets/:slug" do
    redirect "/tickets/:id"
  end

  # DELETE: /tickets/5/delete
  delete "/tickets/:id/delete" do
    redirect "/tickets"
  end
end
