class ProfileDecorator < Draper::Decorator
  delegate :surname, :name, :avatar, :avatar_cache, :remove_avatar, :avatar?, :patronymic, :mail, :update_attributes,
           :to_key, :persisted?, :errors, :user
  decorates_association :company

  def first_and_last_name
    "#{surname} #{name}"
  end

  def link_to_company
    if company
      h.link_to company.opf_and_name, h.admin_company_path(company)
    else
      h.t(".bad_info")
    end
  end

  def created_at
    h.l source.created_at, format: :long
  end
end
