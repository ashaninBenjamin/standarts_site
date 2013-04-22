class HelpDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def number_with_name
    "#{number}. #{name}"
  end

end
