class CompanyDecorator < Draper::Decorator
  delegate :logo, :opf, :name
  decorates_association :user
  decorates_association :profile

  def opf_and_name
    "#{opf} #{name}"
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
