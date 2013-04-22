class UserDecorator < Draper::Decorator
  delegate_all

  def link_to_company
    if model.company
      h.link_to model.company.decorate.opf_and_name, h.admin_company_path(model.company)
    else
      h.t(".bad_info")
    end
  end

  def link_to_profile
    if model.profile
      h.link_to model.profile.decorate.first_and_last_name, h.admin_profile_path(model.profile)
    else
      h.t(".bad_info")
    end
  end

  def created_at
    source.created_at.strftime("%d.%m.%Y %T")
  end

end
