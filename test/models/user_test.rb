require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do   
    @user.name = "    "
    assert_not @user.valid?
  end 

  test "email should be present" do    
    @user.email = "    "
    assert_not @user.valid?
  end 

  test "email should be unique " do   
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end 

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "name and email combination should be unique" do    
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end 

  test "same name but different email should be OK" do   
    duplicate_user = @user.dup
    duplicate_user.email = "something@email.com"
    @user.save
    assert duplicate_user.valid?
  end 

  test "updated password should be different from existing one" do    
    @user.save
    last_user = User.last
    last_user.update_attributes(
      name: @user.name,
      email: @user.email,
      password: @user.password,
      password_confirmation: @user.password_confirmation
    )

    assert_not last_user.valid?
  end 

end
