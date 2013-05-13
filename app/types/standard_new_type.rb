class StandardNewType < Standard
  include BaseType

  def available_numbers(user)
    user.standards.roots.first.node_numbers
  end

  def available_parents(user)
    user.standards
  end
end
