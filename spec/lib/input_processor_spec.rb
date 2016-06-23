require 'spec_helper'
require 'robot'
require 'input_processor'

describe InputProcessor do
  subject(:ip) { InputProcessor.new }
  let(:robot) { Robot.new }
  
  context "before first valid 'place' command" do
    it "should not allow the robot to move" do
      expect(robot).to_not receive(:move)
      ip.process_commands(robot, "MOVE")
    end
    
    it "should not allow the robot to turn left" do
      expect(robot).to_not receive(:left)
      ip.process_commands(robot, "LEFT")
    end
    
    it "should not allow the robot to turn right" do
      expect(robot).to_not receive(:right)
      ip.process_commands(robot, "RIGHT")
    end
    
    it "should not allow the robot to report its position" do
      expect(robot).to_not receive(:report)
      ip.process_commands(robot, "REPORT")
    end
  end
  
  context "after first valid 'place' command" do
    let(:place) { "PLACE 1,1,NORTH " }
    
    it "should allow the robot to be placed" do
      robot.should_receive(:place)
      ip.process_commands(robot, place)
    end
    
    it "should allow the robot to move" do
      robot.should_receive(:move)
      cmd = place + "MOVE"
      ip.process_commands(robot, cmd)
    end
    
    it "should allow the robot to turn left" do
      robot.should_receive(:left)
      cmd = place + "LEFT"
      ip.process_commands(robot, cmd)
    end
    
    it "should allow the robot to turn right" do
      robot.should_receive(:right)
      cmd = place + "RIGHT"
      ip.process_commands(robot, cmd)
    end
    
    it "should allow the robot to report its position" do
      robot.should_receive(:report)
      cmd = place + "REPORT"
      ip.process_commands(robot, cmd)
    end
    
    it "should ignore commands other than place, move, left, right and report" do
      expect(robot).to receive(:move)
      cmd = place + "RANDOM_COMMAND MOVE"
      ip.process_commands(robot, cmd)
    end
  end
end