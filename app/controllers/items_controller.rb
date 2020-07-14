class ItemsController < ApplicationController

  # GET: /items
  get "/items" do
    logged_in_else_redirect_login
    @items = current_user.items
    erb :"/items/index.html"
  end

  # GET: /items/new
  get "/items/new/:id" do
    @listing = current_user.listings.find_by_id(params[:id])
    erb :"/items/new.html"
  end

    # POST: /items/new
  post "/items/new/:id" do
    item = Item.new(name:params[:name],category:params[:category],price:params[:price])
    item.save
    listing = current_user.listings.find_by_id(params[:id])
    listing.items<<item
    redirect "/listings/#{listing.id}"
  end

  # POST: /items
  post "/items" do
    redirect "/items"
  end

  # GET: /items/5/edit
  get "/items/:id/edit" do
    @item = Item.all.find_by_id(params[:id])
    erb :"/items/edit.html"
  end

  get "/items/restore" do
    if logged_in?
    @items = current_user.items
    erb :"/items/restore_sold.html"
    else
      redirect '/'
    end 
  end

  patch "/items/:id/sold" do
    if logged_in?
      item = current_user.items.find_by_id(params[:id])
      if item
          if item.update(sold:params[:name])
              redirect "/items"
          end
      else
        redirect '/users'
    end
  else
      redirect '/users/login'
  end
  end
  
  # PATCH: /items/5
  patch "/items/:id" do
    if logged_in?
      item = current_user.items.find_by_id(params[:id])
      if item
          if item.update(name:params[:name],category:params[:category], price:params[:price])
              redirect "/listings/#{item.listing.id}"
          else
              redirect "/items/#{item.id}/edit"
          end
      else
        redirect '/users'
    end
  else
      redirect '/users/login'
  end
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
