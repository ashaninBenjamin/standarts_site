class Point < ActiveRecord::Base
  belongs_to :block, :primary_key => 'id', :foreign_key => 'block_id'
  belongs_to :point, :primary_key => 'id', :foreign_key => 'parent_id'

  attr_accessible :name, :content, :block_id
end
