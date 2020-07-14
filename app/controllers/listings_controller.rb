class ListingsController < ApplicationController

  # GET: /listings
  get "/listings" do
    variable = Listing.all.collect {|l| l.items}
    @test = variable.flatten
    erb :"/listings/index.html"
  end

  # GET: /listings/new
  get "/listings/new" do
    logged_in_else_redirect_login
      erb :"/listings/new.html"
  end

  # POST: /listings
  post "/listings/new" do
    listing = Listing.new(params)
    listing.save
    current_user.listings<<listing
    redirect "/items/new/#{listing.id}"
  end

  # GET: /listings/5
  get "/listings/:id" do
    logged_in_else_redirect_login
    @listing  = Listing.all.find_by_id(params[:id])
    erb :"/listings/show.html"
  end

  # GET: /listings/5/edit
  get "/listings/:id/edit" do
    logged_in_else_redirect_login
      @listing  = current_user.listings.find_by_id(params[:id])
      erb :"/listings/edit.html"
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
