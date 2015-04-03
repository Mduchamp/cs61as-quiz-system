When /^I am in (.*) browser$/ do |name|
    Capybara.session_name = name
end
