class StandardEditType < Standard
  include BaseType

  def available_numbers(user)
    ((parent ? parent.node_numbers : user.standards.root_numbers) << number).sort
  end

  def available_parents(user)
    user.standards.exclude(subtree)
  end
end
