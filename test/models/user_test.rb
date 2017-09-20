require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new( name:"Test User", 
                      email: "test@user.com",
                      password: "example123", 
                      password_confirmation: "example123" 
                    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "        "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "       "
    assert_not @user.valid?
  end

  test "name should not exceed maximum length" do
    @user.name = "a" * 30
    assert_not @user.valid?
  end

  test "email should not exceed maximum length"  do
    @user.email = "a" * 30 + "@test.com"
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user1@test.com USER2@example.COM USER-3@te.st.org user.4@te.st user+5@foo.bar]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@test,com user.at.test.com user@test.com@test.com user@example+test.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be saved as lower case" do
    mixed_case_email = "UsEr@TeST.coM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (not blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do 
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do 
      @user.destroy 
    end
  end

  test "should follow and unfollow a user" do 
    john = users(:john)
    jane = users(:jane)
    assert_not john.following?(jane)
    john.follow(jane)
    assert john.following?(jane)
    assert jane.followers.include?(john)
    john.unfollow(jane)
    assert_not john.following?(jane)
  end

  test "feed should have the right posts" do
    john  = users(:john)
    jane  = users(:jane)
    bob  = users(:bob)
    # Posts from followed user
    bob.microposts.each do |post_following|
      assert john.feed.include?(post_following)
    end
    # Posts from self
    john.microposts.each do |post_self|
      assert john.feed.include?(post_self)
    end
    # Posts from unfollowed user
    jane.microposts.each do |post_unfollowed|
      assert_not john.feed.include?(post_unfollowed)
    end
  end

end


























