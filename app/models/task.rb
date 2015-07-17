require_relative "../../config/environment"

class Task < ActiveRecord::Base
belongs_to :list 

  
end