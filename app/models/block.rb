class Block < ActiveRecord::Base
  belongs_to :user, :primary_key => 'id', :foreign_key => 'user_id'
  belongs_to :block_content, :primary_key => 'id', :foreign_key => 'block_content_id'

  attr_accessible :name, :content
end
