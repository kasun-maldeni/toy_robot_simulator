class InputProcessor
  COMMANDS = ["place", "move", "left", "right", "report"]
  
  def process_commands(robot, raw_commands)
    commands = raw_commands.downcase.split(' ')
    commands.each { |cmd|
      if robot.currently_placing
        cmd = cmd.split(',')
        robot.send(:place, {x: cmd[0].to_i, y: cmd[1].to_i, f: cmd[2]})
      elsif cmd == "place"
        robot.currently_placing = true
        next
      elsif robot.successfully_placed && verify_command?(cmd)
        robot.send(cmd.to_sym)
      end
    }
  end
  
  private
  def verify_command?(cmd)
    COMMANDS.include?(cmd)
  end
end
