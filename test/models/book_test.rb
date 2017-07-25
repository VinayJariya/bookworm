require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  def setup
  		@user = users(:michael)
  		@book = @user.books.build(name: "RUBY ON RAILS TUTORIAL (RAILS 5)",
  						 author: "Michael Hartl",
  						 description: "This Ruby on Rails Tutorial book teaches you how to develop and deploy real, industrial-strength web applications with Ruby on Rails. 
  						 This open-source web framework powers top websites such as Twitter, Hulu, GitHub, and the Yellow Pages.", 
  						 )
  	end

  	test "should be a valid book" do
  		assert @book.valid?
  	end

  	test "name should not be blank" do
  		@book.name = ""
  		assert_not @book.valid?
  	end

  	test "author should not be blank" do
  		@book.author = ""
  		assert_not @book.valid?
  	end

  	test "description should not be blank" do
  		@book.description = ""
  		assert_not @book.valid?
  	end

  	test "book must belong to a user (user_id should be present)" do
  		@book.user_id = nil
  		assert_not @book.valid?
  	end

  	test "order should be most recent first" do
  	assert_equal books(:season_3), Book.first
    assert_equal books(:season_2), Book.last       
  	end

end
