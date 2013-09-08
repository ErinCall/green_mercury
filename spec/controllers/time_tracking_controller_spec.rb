require 'spec_helper'

describe TimeTrackingController do
  describe "logged in" do
    before :each do
      @user = User.create!
      controller.stub current_user: @user
    end
    describe "index" do
      it "should list your total volunteer hours" do
        @user.stub volunteer_hours: 8
        get :index
        controller.instance_variable_get(:@hours).should == 8
      end

      it "should list how far you have to go to a perk" do
        @user.stub volunteer_hours: 10
        get :index
        controller.instance_variable_get(:@hours_to_go).should == 30
      end

      it "should require volunteering more than 0 hours" do
        post :track, volunteer_block: {hours: 0, on: '20120509'}
        VolunteerBlock.count.should == 0
        controller.instance_variable_get(:@volunteer_block).
          errors.messages.should == {
            hours: ["must be greater than 0"]
        }
      end
    end
  end

  describe "logged out" do
    it "should require login" do
      get :index
      response.should be_redirect
      response.headers['Location'].should == 'http://test.host/users/sign_in'
    end
  end
end
