module StandardRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :all_by_super_admin, -> { with(user_id: User.super_admins) }

    def self.get_by_link(link)
      numbers = link.split('-').map { |number_s| number_s.to_i }

      standard = roots.first
      numbers.each do |number|
        standard = standard.children.with(number: number).first
        break unless standard
      end
      standard
    end

    def self.stem
      roots.first.descendants
    end

  end
end