class Company < ActiveRecord::Base
  attr_accessible :logo, :name, :opf
  has_attached_file :logo, :styles => { :large => "300x300>", :medium => "200x200>" }

  #validates_attachment_presence :logo
  validates_attachment_size :logo, :less_than => 2.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']

  validates :opf, :name, :presence => true
end
