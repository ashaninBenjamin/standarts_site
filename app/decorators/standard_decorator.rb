class StandardDecorator < Draper::Decorator
  delegate :id, :number, :depth, :name, :content, :update_attributes, :to_key, :parent_id,
           :access_state_transitions, :access_state_event, :state, :persisted?
  decorates_association :parent
  decorates_association :children
  decorates_association :descendants

  def for_select
    ("-" * depth) + "#{code} #{name}"
  end

  def code
    ret = number.to_s
    temp = source
    while temp.parent
      temp = temp.parent
      ret = "#{temp.number}.#{ret}"
    end
    ret
  end

  def link
    code.gsub(".", "-")
  end

  def code_with_name
    "#{code}. #{name}"
  end

end
