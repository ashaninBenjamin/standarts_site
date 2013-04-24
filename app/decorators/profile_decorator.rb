class ProfileDecorator < Draper::Decorator
  delegate :surname, :name, :avatar
  decorates_association :user
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
    source.created_at.strftime("%d.%m.%Y %T")
  end
end
