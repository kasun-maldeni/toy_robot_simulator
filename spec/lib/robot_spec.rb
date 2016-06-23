require 'spec_helper'
require 'robot'

describe Robot do
  subject(:robot) { Robot.new }
  
  context "before a valid 'place' command is executed" do
    it 'should not have an x co-ordinate' do
      robot.x.should be_nil
    end
    
    it 'should not have a y co-ordinate' do
      robot.y.should be_nil
    end
    
    it 'should not have a facing direction' do
      robot.f.should be_nil
    end
  end
  
  context "when trying to execute a valid 'place' command" do
    it "should not accept an x co-ordinate outside the range of the grid" do
      expect { robot.place(x: 6, y: 1, f: "north") }.to_not change { robot.x }
    end
    
    it "should not accept a y co-ordinate outside the range of the grid" do
      expect { robot.place(x: 2, y: 6, f: "north") }.to_not change { robot.y }
    end
    
    it "should not accept a co-ordinate that is not an integer" do
      expect { robot.place(x: "a", y: 2, f: "north") }.to_not change { robot.x }
    end
    
    it "should not accept a direction outside of north, south, east or west" do
      expect { robot.place(x: 1, y: 1, f: "random") }.to_not change { robot.f }
    end
  end
  
  context "after a valid 'place' command is executed" do
    before { robot.place(x: 2, y: 3, f: "north") }
    
    # Left Turn
    it "should change its facing direction from north to west when turning 'left'" do
      robot.f = "north"
      expect { robot.left }.to change { robot.f }.from("north").to("west")
    end
    
    it "should change its facing direction from west to south when turning 'left'" do
      robot.f = "west"
      expect { robot.left }.to change { robot.f }.from("west").to("south")
    end
    
    it "should change its facing direction from south to east when turning 'left'" do
      robot.f = "south"
      expect { robot.left }.to change { robot.f }.from("south").to("east")
    end
    
    it "should change its facing direction from east to north when turning 'left'" do
      robot.f = "east"
      expect { robot.left }.to change { robot.f }.from("east").to("north")
    end
    
    # Right Turn
    it "should change its facing direction from north to east when turning 'right'" do
      robot.f = "north"
      expect { robot.right }.to change { robot.f }.from("north").to("east")
    end
    
    it "should change its facing direction from east to south when turning 'right'" do
      robot.f = "east"
      expect { robot.right }.to change { robot.f }.from("east").to("south")
    end
    
    it "should change its facing direction from south to west when turning 'right'" do
      robot.f = "south"
      expect { robot.right }.to change { robot.f }.from("south").to("west")
    end
    
    it "should change its facing direction from west to north when turning 'right'" do
      robot.f = "west"
      expect { robot.right }.to change { robot.f }.from("west").to("north")
    end
    
    # Move
    it "should be moving north when facing 'north' and using the 'move' command" do
      expect { robot.move }.to change { robot.y }.by(1)
    end
    
    it "should be moving east when facing 'east' and using the 'move' command" do
      robot.f = "east"
      expect { robot.move }.to change { robot.x }.by(1)
    end
    
    it "should be moving south when facing 'south' and using the 'move' command" do
      robot.f = "south"
      expect { robot.move }.to change { robot.y }.by(-1)
    end
    
    it "should be moving west when facing 'west' and using the 'move' command" do
      robot.f = "west"
      expect { robot.move }.to change { robot.x }.by(-1)
    end
    
    # Report
    it "should be outputting its position when executing 'report'" do
      $stdout.should_receive(:write)
      robot.report
    end
    
    context "when robot is on the edge of the grid" do
      it "should not be able to 'move' north when its at the northern most point in the grid" do
        robot.place(x: 2, y: 5, f: "north")
        expect { robot.move }.to_not change { robot.y }
      end
      
      it "should not be able to 'move' east when its at the eastern most point in the grid" do
        robot.place(x: 5, y: 3, f: "east")
        expect { robot.move }.to_not change { robot.x }
      end
      
      it "should not be able to 'move' south when its at the southern most point in the grid" do
        robot.place(x: 3, y: 0, f: "south")
        expect { robot.move }.to_not change { robot.y }
      end
      
      it "should not be able to 'move' west when its at the western most point in the grid" do
        robot.place(x: 0, y: 0, f: "west")
        expect { robot.move }.to_not change { robot.x }
      end
    end
  end
end
