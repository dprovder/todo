require_relative "../../config/environment"

class List < ActiveRecord::Base
has_many :tasks

end
