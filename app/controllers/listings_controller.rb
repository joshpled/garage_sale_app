class ListingsController < ApplicationController

  # GET: /listings
  get "/listings" do
    erb :"/listings/index.html"
  end

  # GET: /listings/new
  get "/listings/new" do
    if logged_in?
      erb :"/listings/new.html"
    else
      redirect '/users'
    end
  end

  # POST: /listings
  post "/listings/new" do
    listing = Listing.new(params)
    listing.save
    current_user.listings<<listing
    if listing
    redirect "/users"
    else
      redirect "/listings/new"
    end 
  end

  # GET: /listings/5
  get "/listings/:id" do
    if logged_in?
    @listing  = Listing.all.find_by_id(params[:id])
    erb :"/listings/show.html"
    else
      redirect "/users"
    end 
  end

  # GET: /listings/5/edit
  get "/listings/:id/edit" do
    erb :"/listings/edit.html"
  end

  # PATCH: /listings/5
  patch "/listings/:id" do
    redirect "/listings/:id"
  end

  # DELETE: /listings/5/delete
  delete "/listings/:id/delete" do
    redirect "/listings"
  end
end
