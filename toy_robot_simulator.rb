require_relative 'lib/robot'
require_relative 'lib/input_processor'

while line = $stdin.gets
    robot = Robot.new
    InputProcessor.new.process_commands(robot, line)
end