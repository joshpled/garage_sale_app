require "./config/environment"
require "sinatra/base"
require "rack-flash"
require "Date"
require "pry"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get "/" do
    if current_user && logged_in?
      redirect "/users"
    else
      erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def logged_in_else_redirect_login
      if !logged_in?
        redirect "/users/login"
      end
    end

    def logged_in_else_redirect_home
      if !logged_in?
        redirect "/"
      end
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in?
    end

    def logout!
      session.clear
    end

    def create_user_error_messages(user)
      flash[:password_error] = user.errors.messages[:password]
      flash[:password_confirmation] = user.errors.messages[:password_confirmation]
      flash[:email_error] = user.errors.messages[:email]
      flash[:name_error] = user.errors.messages[:first_name]
      flash[:username_error] = user.errors.messages[:username]
    end

    def create_user_error_messages_reader
      @password_error = flash[:password_error]
      @passconfirm_error = flash[:password_confirmation]
      @email_error = flash[:email_error]
      @username_error = flash[:username_error]
      @name_error = flash[:name_error]
    end
  end
end
