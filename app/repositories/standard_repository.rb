module StandardRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :all_by_super_admin, -> { with(user_id: User.super_admins) }

    def self.find_by_link(link)
      numbers = link.split('-').map { |number_s| number_s.to_i }

      standard = with(number: 0).first
      numbers.each do |number|
        standard = standard.children.with(number: number).first
        break unless standard
      end
      standard
    end

    def self.root
      with(number: 0).first
    end

    def self.stem
      with(number: 0).first.descendants
    end

  end
end