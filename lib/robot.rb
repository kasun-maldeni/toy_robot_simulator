class Robot
  attr_accessor :x, :y, :f
  
  X_RANGE = 0..5
  Y_RANGE = 0..5
  
  def place(opts={})
  	self.x = opts[:x]
  	self.y = opts[:y]
  	self.f = opts[:f]
  end
  
  def move
    if self.f == "north" && self.y < Y_RANGE.max
    	self.y += 1
    elsif self.f == "east" && self.x < X_RANGE.max
    	self.x += 1
    elsif self.f == "south" && self.y > Y_RANGE.min
    	self.y -= 1
    elsif self.f == "west" && self.x > X_RANGE.min
    	self.x -= 1
    end
  end
end
