require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "should get new if logged_in" do 
  	log_in_as(@user)
  	get new_book_path
  	assert_template 'books/new'
  	
  end

  test "should redirect new if not logged in" do
  	get new_book_path
  	assert_redirected_to login_url
  end
 
end
