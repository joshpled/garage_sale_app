class ItemsController < ApplicationController

  # GET: /items
  get "/items" do
    erb :"/items/index.html"
  end

  # GET: /items/new
  get "/items/new" do
    binding.pry
    erb :"/items/new.html"
  end

    # POST: /items/new
  post "/items/new" do
    item = Item.new(params)
    item.save
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
  delete "/items/:id/delete" do
    redirect "/items"
  end
end
