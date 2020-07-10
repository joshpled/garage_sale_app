class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    if logged_in?
      erb :"/users/show.html"
    else
      redirect :'/'
    end 
  end

  # GET: /users/new
  get "/users/signup" do
    if logged_in?
      redirect '/users'
    else
      erb :"/users/new.html"
    end
  end 
  
  #GET: /users/login
  get '/users/login' do
    if logged_in?
      redirect '/users'
    else
      erb :"/users/login.html"
    end
  end

  get '/users/delete' do
    if logged_in?
      erb :"users/delete_account.html"
    else
      erb :"/users/login.html"
    end
  end

  #POST: /users/signup
  post "/users/signup" do
    @user = User.new(params)
    if @user.save
        session[:user_id] = @user.id
        redirect '/users'
    else
        redirect '/users/signup'
    end
  end 

  # POST: /users 
  post "/users/login" do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/users'
      else
          redirect '/users/login'
      end
  end
  
  #GET: /users/logout
  get '/users/logout' do 
    if logged_in?
      logout!
      redirect '/'
    end
      redirect '/'
  end 


  delete "/users/:id" do
    if logged_in?
      user = User.all.find_by_id(params[:id])
      if user
        user.items.each do |i|
          Items.all.find_by_id(i.id).delete
        end 
        user.listings.each do |l|
          Listing.all.find_by_id(l.id).delete
        end 
        user.delete
        session.clear
      end
      redirect '/'
      else
        redirect '/users/login'
      end
    end

end 

