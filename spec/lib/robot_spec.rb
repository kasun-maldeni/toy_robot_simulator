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
  
  context "after a valid 'place' command is executed" do
    before { robot.place(x: 2, y: 3, f: "north") }
    
    it "should increase the y co-ordinate when facing 'north' by using the 'move' command" do
      expect { robot.move }.to change { robot.y }.by(1)
    end
    
    it "should increase the x co-ordinate when facing 'east' by using the 'move' command" do
      robot.f = "east"
      expect { robot.move }.to change { robot.x }.by(1)
    end
    
    it "should decrease the y co-ordinate when facing 'south' by using the 'move' command" do
      robot.f = "south"
      expect { robot.move }.to change { robot.y }.by(-1)
    end
    
    it "should decrease the x co-ordinate when facing 'west' by using the 'move' command" do
      robot.f = "west"
      expect { robot.move }.to change { robot.x }.by(-1)
    end
    
    context "when robot is on the edge of the grid" do
      it "should not be able to 'move' north when its y co-ordinate is at its max" do
        robot.place(x: 2, y: 5, f: "north")
        expect { robot.move }.to_not change { robot.y }
      end
      
      it "should not be able to 'move' east when its x co-ordinate is at its max" do
        robot.place(x: 5, y: 3, f: "east")
        expect { robot.move }.to_not change { robot.x }
      end
      
      it "should not be able to 'move' south when its y co-ordinate is at its min" do
        robot.place(x: 3, y: 0, f: "south")
        expect { robot.move }.to_not change { robot.y }
      end
      
      it "should not be able to 'move' west when its x co-ordinate is at its min" do
        robot.place(x: 0, y: 0, f: "west")
        expect { robot.move }.to_not change { robot.x }
      end
    end
  end
end
