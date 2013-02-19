class AddTimestampsToUserInfo < ActiveRecord::Migration
  def change
    change_table(:user_infos) { |t| t.timestamps }
  end
end
