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
    redirect '/items/new'
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
    if logged_in?
      @listing  = current_user.listings.find_by_id(params[:id])
      erb :"/listings/edit.html"
      else
        redirect "/users"
      end 
  end

  # PATCH: /listings/5
  patch "/listings/:id" do
    if logged_in?
      listing = current_user.listings.find_by_id(params[:id])
      if listing
          if listing.update(title: params[:title], description: params[:description])
              redirect "/listings/#{listing.id}"
          else
              redirect "/listings/#{listing.id}/edit"
          end
      else
        redirect '/listings'
    end
  else
      redirect '/users/login'
  end
  end

  # DELETE: /listings/5/delete
  delete "/listings/:id" do
        if logged_in?
          listing = Listing.find_by_id(params[:id])
          if listing
              listing.items.each do |i|
                Item.all.find_by_id(i.id).delete
              end 
              listing.delete
          end
          redirect '/users'
      else
          redirect '/users/login'
      end
    end
  end 
