Given /^I am on the (Staff|Student) Dashboard/ do |user_type|
    if user_type == "Student"
        visit students_dashboard_path
    elsif user_type == "Staff"
        visit staffs_dashboard_index_path
    end
end
