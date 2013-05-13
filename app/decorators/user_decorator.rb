class UserDecorator < Draper::Decorator
  delegate :id, :login, :super_admin?, :correct?, :standards, :destroy, :build_profile, :build_company,
           :to_key, :persisted?, :save
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
    h.l source.created_at, format: :long
  end

end
