class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name, :limit => 100
      t.text :content
      t.string :value
      t.references :city
      t.references :user
      t.references :category
      t.boolean :situation, :default => true
      t.timestamps
    end
    add_index :announcements, :city_id
    add_index :announcements, :user_id
  end
end
