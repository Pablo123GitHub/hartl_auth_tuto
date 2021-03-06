require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup information "  do   
    get signup_path
    assert_no_difference 'User.count' do   
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"
        }}
    end
    assert_template 'users/new'
    assert_select "div.alert"
    assert_select "div#error_explanation"
    assert_select 'form[action="/signup"]'
 end 

 test 'valid registration' do   
   get signup_path
   assert_difference 'User.count' do   
      post users_path, params: { user: {
                                       name: "Jonathan Carter",
                                       email: "jon@carter.com",
                                       password: "password",
                                       password_confirmation: "password"
                                 
      }}
      end   
   assert_not flash[:success].empty?
   follow_redirect!
   assert_template 'users/show'
 end 


end
