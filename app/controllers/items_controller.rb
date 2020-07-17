class ItemsController < ApplicationController
  get "/items" do
    logged_in_else_redirect_login
    @items = current_user.items
    erb :"/items/index.html"
  end

  get "/items/new/:id" do
    logged_in_else_redirect_login
    @listing = current_user.listings.find_by_id(params[:id])
    if @listing.user_id == session[:user_id]
    erb :"/items/new.html"
    else
      redirect '/'
    end
  end

  post "/items/new/:id" do
    item = Item.new(name: params[:name], category: params[:category], price: params[:price])
    item.save
    listing = current_user.listings.find_by_id(params[:id])
    listing.items << item
    redirect "/listings/#{listing.id}"
  end

  post "/items" do
    redirect "/items"
  end

  get "/items/:id/edit" do
    @item = Item.all.find_by_id(params[:id])
    if @item.user.id == session[:user_id]
    erb :"/items/edit.html"
    else
      redirect '/'
    end
  end

  get "/items/restore" do
    logged_in_else_redirect_login
      @items = current_user.items
      erb :"/items/restore_sold.html"
  end

  patch "/items/:id/sold" do
    logged_in_else_redirect_login
    item = current_user.items.find_by_id(params[:id])
    if item
      case item.sold
      when false
        item.update(sold: true)
      else
        item.update(sold: false)
      end
      redirect back
    end
  end

  patch "/items/:id" do
    logged_in_else_redirect_login
      item = current_user.items.find_by_id(params[:id])
      if item
        if item.update(name: params[:name], category: params[:category], price: params[:price])
          redirect "/listings/#{item.listing.id}"
        else
          redirect "/items/#{item.id}/edit"
        end
      end
  end

  post "/items/:id" do
    item = Item.find_by_id(params[:id])
    listing = Listing.all.find_by_id(item.listing.id)
    listing.items.find_by_id(params[:id]).delete
    item.delete
    redirect "/listings/#{listing.id}"
  end

  delete "/items/:id/delete" do
    item = Item.find_by_id(params[:id])
    listing = Listing.all.find_by_id(item.listing.id)
    listing.items.find_by_id(params[:id]).delete
    item.delete
    redirect "/listings/#{listing.id}"
  end
  
end
