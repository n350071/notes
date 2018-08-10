class Model < ActiveRecord::Base
  establish_connection "slave_database"

end
