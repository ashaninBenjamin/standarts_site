class StandardEditType < Standard
  include BaseType

  def available_numbers
    numbers = parent.node_numbers
    numbers << number
    numbers.sort
  end

  def available_parents(user)
    user.standards.exclude(subtree)
  end
end
