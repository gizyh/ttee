Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
  	unconfirmed = attributes.delete("unconfirmed") == "true"
    admin = attributes.delete("admin") == "true"
  	@user = User.create!(attributes)
    @user.update_attribute("admin", admin)
  	@user.confirm! unless unconfirmed
  end
end

When /^I check "([^\"]*)"$/ do |label|
  check(label)
end

Given /^I am signed in as them$/ do
  steps(%Q{
  	Given I am on the homepage
  	When I follow "Sign in"
  	And I fill in "Email" with "#{@user.email}"
  	And I fill in "Password" with "password"
  	And I press "Sign in"
  	Then I should see "Signed in successfully."
  })
end