class UsersController < ApplicationController


  # GET: /users
  get "/users" do
    if logged_in?
      erb :"/users/show.html"
    else
      redirect :'/'
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
          redirect '/login'
      end
  end

end 

