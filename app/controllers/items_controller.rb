class ItemsController < ApplicationController

  # GET: /items
  get "/items" do
    erb :"/items/index.html"
  end

  # GET: /items/new
  get "/items/new" do
    erb :"/items/new.html"
  end

    # POST: /items/new
  post "/items/new" do
    item = Item.new(params)
    item.save
    current_user.listings.last.items<<item
    redirect "/listings/#{current_user.listings.last.id}"
  end

  post "items/new/more" do
    item = item.new(params)
    item.save
    redirect '/items/new'
  end 

  # POST: /items
  post "/items" do
    redirect "/items"
  end

  # GET: /items/5
  get "/items/:id" do
    erb :"/items/show.html"
  end

  # GET: /items/5/edit
  get "/items/:id/edit" do
    erb :"/items/edit.html"
  end

  # PATCH: /items/5
  patch "/items/:id" do
    redirect "/items/:id"
  end

  # DELETE: /items/5/delete
  post "/items/:id" do

    item = Item.find_by_id(params[:id])
    listing = Listing.all.find_by_id(item.listing.id)
    listing.items.find_by_id(params[:id]).delete
    item.delete
    redirect "/listings/#{listing.id}"
  end
end
