require './config/environment'
require 'sinatra/base'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret" 
    use Rack::Flash
  end

  get "/" do
    if current_user && logged_in?
      redirect '/users'
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
        redirect '/users/login'
      end
    end 

    def logged_in_else_redirect_home
      if !logged_in?
        redirect '/'
      end 
    end 

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in?
    end

    def logout!
      session.clear
    end

    


  end

end
