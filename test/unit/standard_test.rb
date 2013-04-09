require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  def setup
    @user = create :user
    @standard = create :standard, user: @user
    @children = create :standard, user: @user, parent: @standard
  end

  test "find_root_numbers" do
    assert (@user.standards.root_numbers == [2])
  end

  test "find_standard_node_numbers" do
    assert (@standard.node_numbers == [2])
  end

  test "find_child_node_numbers" do
    assert (@children.node_numbers == [1])
  end
end
