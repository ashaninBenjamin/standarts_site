class UserDecorator < Draper::Decorator
  delegate :login, :super_admin?
  decorates_association :profile
  decorates_association :company

  def link_to_company
    if company
      h.link_to company.opf_and_name, h.admin_company_path(company)
    else
      h.t(".bad_info")
    end
  end

  def link_to_profile
    if profile
      h.link_to profile.first_and_last_name, h.admin_profile_path(profile)
    else
      h.t(".bad_info")
    end
  end

  def created_at
    source.created_at.strftime("%d.%m.%Y %T")
  end

end
