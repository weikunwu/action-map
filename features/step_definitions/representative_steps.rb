


Given /the following representatives exist/ do |representatives_table|
    representatives_table.hashes.each do |representative|
      Representative.create representative
    end
  end

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
    fill_in(field, :with => value)
end

When /^(?:|I )press '([^"]*)'$/ do |button|
    click_button(button)
end

When("I follow {string}") do |string|
    # puts page.body
    link = string + "Donald J. Trump"
    click_link(link)
end

Then("I should see {string}") do |string|
    if page.respond_to? :should
        page.should have_content(text)
    else
        assert page.has_content?(text)
    end
end

Then("I should not see {string}") do |string|
    if page.respond_to? :should
        !page.should have_content(text)
    else
        !assert page.has_content?(text)
    end
end

def path_to(page_name)
    case page_name
    when /search page/i then 
        representatives_path
    when /profile page/i then
        representative_profile_page_path(1)
    when /results page/i then
        search_representatives_path("california")
    end

end