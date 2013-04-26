class RemoveIndexIpFromSessionHistory < ActiveRecord::Migration
  def up
    remove_index :session_histories, :ip
  end

  def down
    add_index :session_histories, :ip
  end
end
