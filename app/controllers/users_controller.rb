class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    logged_in_else_redirect_login
    erb :"/users/show.html"
  end

  # GET: /users/new
  get "/users/signup" do
    @signup_error = flash[:signup_error]
    if logged_in?
      redirect '/users'
    else
      erb :"/users/new.html"
    end
  end 
  
  #GET: /users/login
  get '/users/login' do
    @login_error = flash[:login_error]
    erb :"/users/login.html"
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
          flash[:login_error] = "Please enter the correct username or password"
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
  
  get '/users/edit' do
    erb :"/users/change_user.html"
  end

  patch "/users/:id" do
    if logged_in?
      user = User.all.find_by_id(params[:id])
      if user
        user.update(params)
      else
        redirect '/users/edit'
      end 
    else
      redirect '/'
    end
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

