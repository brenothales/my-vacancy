class JoinTagAndAnnouncement < ActiveRecord::Migration
  def up
    create_table :announcements_tags, :id => false do |t|
      t.references :announcements
      t.references :tags    
    end
  end

  def down
    drop_table :announcements_tags
  end
end
