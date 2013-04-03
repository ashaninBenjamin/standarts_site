require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  def setup
    @user = create :user
    @standard = create :standard, user: @user
    @children = create :standard, user: @user, parent: @standard
  end

  test "find_numbers_by_user" do
    assert (Standard.find_numbers(@user) == [2])
  end

  test "find_numbers_by_parent" do
    assert (Standard.find_numbers(@standard) == [2])
  end

  test "find_number_by_children" do
    assert (Standard.find_numbers(@children) == [1])
  end

end
