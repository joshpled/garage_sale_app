class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    logged_in_else_redirect_login
    erb :"/users/show.html"
  end

  # GET: /users/new
  get "/users/signup" do
    create_user_error_messages_reader
    erb :"/users/new.html"
  end

  post "/users/signup" do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect "/users"
    else
      create_user_error_messages(@user)
      redirect "/users/signup"
    end
  end

  get "/users/edit" do
    erb :"/users/change_user.html"
  end

  patch "/users/:id" do
    logged_in_else_redirect_home
      user = User.all.find_by_id(params[:id])
      if user
        user.update(params)
      else
        redirect "/users/edit"
      end
  end

  get "/users/delete" do
    logged_in_else_redirect_login
      erb :"users/delete_account.html"
  end

  delete "/users/:id" do
    logged_in_else_redirect_login
      user = User.all.find_by_id(params[:id])
      if user
        user.items.each do |i|
          Item.all.find_by_id(i.id).delete
        end
        user.listings.each do |l|
          Listing.all.find_by_id(l.id).delete
        end
        user.delete
        session.clear
      end
      redirect '/'
    end 
end
