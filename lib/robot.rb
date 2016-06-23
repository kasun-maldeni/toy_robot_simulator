class Robot
  attr_accessor :x, :y, :f, :currently_placing, :successfully_placed
  
  FACING = ["north", "east", "south", "west"]
  X_RANGE = 0..5
  Y_RANGE = 0..5
  
  def initialize
    self.currently_placing = false
    self.successfully_placed = false
  end
  
  def place(opts={})
    if valid_place_command? opts
    	self.x = opts[:x]
    	self.y = opts[:y]
    	self.f = opts[:f]
    	self.successfully_placed = true
    	self.currently_placing = false
    end
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
  
  def left
    turn { |f| f == 0 ? 3 : f - 1 }
  end
  
  def right
    turn { |f| f == 3 ? 0 : f + 1 }
  end
  
  def report
    puts self
  end
  
  private
  def to_s
    "Output: #{self.x},#{self.y},#{self.f.upcase}\n"
  end
  
  def turn
    f_val = FACING.index(self.f)
    new_f_val = yield f_val
    self.f = FACING[new_f_val]
  end
  
  def valid_place_command?(opts={})
    verify_coordinate?(opts[:x], X_RANGE) &&
    verify_coordinate?(opts[:y], Y_RANGE) &&
    verify_facing?(opts[:f])
  end
  
  def verify_coordinate?(coordinate, range)
    coordinate.is_a?(Integer) && range.include?(coordinate)
  end
  
  def verify_facing?(f)
    FACING.include?(f)
  end
end
