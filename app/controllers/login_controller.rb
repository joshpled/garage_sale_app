class LoginController < ApplicationController
  get "/users/login" do
    @login_error = flash[:login_error]
    erb :"/users/login.html"
  end

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

  get "/users/logout" do
    logged_in_else_redirect_login
    logout!
    redirect "/"
  end
end
