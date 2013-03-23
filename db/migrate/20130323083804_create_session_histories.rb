class CreateSessionHistories < ActiveRecord::Migration
  def change
    create_table :session_histories do |t|
      t.integer :user_id
      t.string :page
      t.string :ip

      t.timestamps
    end
    add_index :session_histories, :ip
  end
end
