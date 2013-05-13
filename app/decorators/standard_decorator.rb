class StandardDecorator < Draper::Decorator
  delegate :id, :number, :depth, :name, :code, :content, :update_attributes, :to_key, :parent_id,
           :access_state_transitions, :access_state_event, :state, :persisted?, :node_numbers, :is_root?
  decorates_association :parent
  decorates_association :children
  decorates_association :descendants

  def for_select
    if number.zero?
      h.t(".select_include_blank")
    else
      ("-" * (depth - 1)) + "#{code} #{name}"
    end
  end

  def code_with_name
    "#{code}. #{name}"
  end

end
