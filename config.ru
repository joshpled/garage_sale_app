require './config/environment'



use Rack::MethodOverride

run ApplicationController
use ItemsController
use ListingsController
use UsersController
