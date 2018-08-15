# You can find the location of the method def
objct.some_method
objct.method(:some_method)
objct.method(:some_method).source_location

# it lists the methods includes `chat` in the method name
User.public_methods.select{|m| m.to_s.include?('chat') }.each{|m| p m }
