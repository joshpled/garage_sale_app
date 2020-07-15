require './config/environment'

use Rack::MethodOverride

use ItemsController
use ListingsController
use UsersController
use LoginController
run ApplicationController