class Robot
  attr_accessor :x, :y, :f
  
  def place(opts={})
  	self.x = opts[:x]
  	self.y = opts[:y]
  	self.f = opts[:f]
  end
  
  def move
    if self.f == "north"
    	self.y += 1
    elsif self.f == "east"
    	self.x += 1
    elsif self.f == "south"
    	self.y -= 1
    elsif self.f == "west"
    	self.x -= 1
    end
  end
end
