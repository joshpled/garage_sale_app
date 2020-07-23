class ListingsController < ApplicationController
  get "/listings" do
    variable = Listing.all.collect { |l| l.items }
    @test = variable.flatten
    erb :"/listings/index.html"
  end

  get "/listings/new" do
    logged_in_else_redirect_login
    erb :"/listings/new.html"
  end

  post "/listings/new" do
    listing = Listing.new(params)
    listing.save
    current_user.listings << listing
    redirect "/items/new/#{listing.id}"
  end

  get "/listings/:id" do
    logged_in_else_redirect_login
    @listing = Listing.all.find_by_id(params[:id])
    erb :"/listings/show.html"
  end

  get "/listings/:id/edit" do
    logged_in_else_redirect_login
      @listing = current_user.listings.find_by_id(params[:id])

    if current_user == session[:user_id] && @listing.user_id == session[:user_id]
      erb :"/listings/edit.html"
    else
      redirect '/'
    end 
  end

  patch "/listings/:id" do
    logged_in_else_redirect_login
      listing = current_user.listings.find_by_id(params[:id])
      if listing
        if listing.update(title: params[:title], description: params[:description])
          redirect "/listings/#{listing.id}"
        else
          redirect "/listings/#{listing.id}/edit"
        end
      end 
        redirect "/listings"
  end

  delete "/listings/:id" do
    logged_in_else_redirect_login
      listing = current_user.listings.find_by_id(params[:id])
      if listing
        listing.items.each do |i|
          Item.all.find_by_id(i.id).delete
        end
        listing.delete
      end
      redirect "/users"
    end 
end
