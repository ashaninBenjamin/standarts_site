class HelpDecorator < Draper::Decorator
  delegate :number, :name, :content

  def number_with_name
    "#{number}. #{name}"
  end

end
