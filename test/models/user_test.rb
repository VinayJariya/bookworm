require 'test_helper'

class UserTest < ActiveSupport::TestCase
  	
  	def setup
  		@user = User.new(name: "Vinay Jariya",
  						 email: "vinayjariya@gmail.com",
  						 contact: "8319069564", 
  						 password: "foobar@123", 
  						 password_confirmation: "foobar@123")
  	end

  	test "should be a valid user" do
  		assert @user.valid?
  	end

  	test "name should be present" do
  		@user.name = ""
  		assert_not @user.valid?
  	end

  	test "email should be present" do
  		@user.email = ""
  		assert_not @user.valid?
  	end

  	test "password should be present" do
	    @user.password = @user.password_confirmation = " " * 6
	    assert_not @user.valid?
  	end

  	test "contact should be present" do
  		@user.contact = ""
  		assert_not @user.valid?
  	end

  	test "name should not exceed maximum length" do
  		@user.name = "a" * 51
  		assert_not @user.valid?
  	end

  	test "email should not exceed maximum length" do
  		@user.email = "a" * 244 + "@example.com"
  		assert_not @user.valid?
  	end

  	test "password should have a minimum length" do
	    @user.password = @user.password_confirmation = "a" * 7
	    assert_not @user.valid?
	end	

  	test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  	test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "user email should be unique" do
  	dup_user = @user.dup
  	dup_user.email.upcase!
  	@user.save
  	assert_not dup_user.valid?
  end

  test "email should be saved as downcase" do
  	mixed_case_email = "FooBar@example.com"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "contact validation should accept valid phone numbers" do
  	valid_contacts = %w[8349120877 8319069564 9039177012 9827617230]
  	valid_contacts.each do |valid_contact|
  		@user.contact = valid_contact
  		assert @user.valid?
  	end
  end

  test "contact validation should reject invalid phone numbers" do
  	invalid_contacts = %w[834912087 83190869564 903917701a 0123456789]
  	invalid_contacts.each do |invalid_contact|
  		@user.contact = invalid_contact
  		assert_not @user.valid?
  	end
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "dependent books must be destroyed" do
    @user.save
    @user.books.create!(name: "TestCase",
                        author: "Test",
                        description: "For Testing Purpose")
    assert_difference 'Book.count', -1 do
      @user.destroy
    end
  end
end
