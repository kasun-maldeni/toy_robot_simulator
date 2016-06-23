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
end