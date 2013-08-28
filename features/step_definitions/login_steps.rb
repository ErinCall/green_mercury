Given(/^I have a social account$/) do
  @user = FactoryGirl.build :social_user
  @user.confirmed_at = Time.now
  @user.save!
end

Given(/^I am signed in$/) do
  login_as(@user, scope: :user)
end

Given(/^my account has a confirmation token$/) do
  @user.confirmation_token = 'randomtext'
  @user.unconfirmed_email = 'foo@bar.baz'
  @user.save!
end

When(/^I fill in "(.+)" with "(.+)"/) do |label, input|
  fill_in label, with: input
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

When(/^I visit my the page to confirm my email$/) do
  visit '/users/confirmation?confirmation_token=randomtext'
end


Then(/^the signup form should be shown again$/) do
  current_path.should == user_registration_path
end

Then(/^I should be on the home page$/) do
  current_path.should == root_path
end

Then(/^I should see "(.*?)"$/) do |text|
  save_and_open_on_error do
    page.should have_content(text)
  end
end

Then(/^I should not see "(.*?)"$/) do |text|
  save_and_open_on_error do
    page.should_not have_content(text)
  end
  save_and_open_page
end

Then(/^"(.+)" should not be registered$/) do |email|
  User.find_by_email(email).should be_nil
end

Then(/^"(.+)" should be registered$/) do |email|
  User.find_by_email(email).should_not be_nil
end

Then(/^"(.+)" should have been sent a confirmation email$/) do |email|
  mails = ActionMailer::Base.deliveries
  mails.length.should == 1
  mails.first.to.should == [email]
  mails.first.subject.should == "Confirm your email address"
end

def save_and_open_on_error
  begin
    yield
  rescue Exception => e
    begin
      save_and_open_page
    rescue Launchy::CommandNotFoundError
    end
    raise e
  end
end
