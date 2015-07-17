require_relative "../../config/environment"

class User < ActiveRecord::Base
has_many :lists

  
end