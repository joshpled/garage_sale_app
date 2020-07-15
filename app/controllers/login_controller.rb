class LoginController < ApplicationController
  get "/users/login" do
    erb :"/users/login.html"
  end

  post "/users/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users"
    else
      redirect "/users/login"
    end
  end

  get "/users/logout" do
    logged_in_else_redirect_login
    logout!
    redirect "/"
  end
end
