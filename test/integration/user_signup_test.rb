require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
 	
 	test "invalid signup info" do
 		get signup_path
 		assert_select "form[action=?]", signup_path
 		assert_no_difference 'User.count' do
 		post users_path, params: {user: {name: "",
 						email: "",
 						contact: "",
 						password: "",
 						password_confirmation: ""}}
 		end
 		assert_template 'users/new'
 		assert_select 'div#error_explanation'
 		assert_select 'div.field_with_errors'
 	end

 	test "valid signup info" do
 		get signup_path
 		assert_difference 'User.count', 1 do
 		post users_path, params: {user: {name: "Example",
 					email: "foobar@example.com",
 					contact: "9876543210",
 					password: "foobar@123",
 					password_confirmation: "foobar@123"}}
 		end
 		follow_redirect!
 		assert_template 'users/show'
 		assert flash[:success]
 	end
end
