class UniqueNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    if value.present?
      if value.nonzero?
        if record.siblings.exclude(record).with(number: value).any?
          record.errors.add(attr, :taken)
        end
      else
        if record.siblings.exclude(record).with(user_id: record.user_id).any?
          record.errors.add(attr, :taken)
        end
      end
    end
  end
end