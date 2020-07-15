class LoginController < ApplicationController

  #GET: /users/login
  get "/users/login" do
    @login_error = flash[:login_error]
    erb :"/users/login.html"
  end

  # POST: /users
  post "/users/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users"
    else
      flash[:login_error] = "Please enter the correct username or password"
      redirect "/users/login"
    end
  end
end
