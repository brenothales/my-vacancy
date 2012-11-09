class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :content
      t.references :announcement
      t.boolean :situation, :default => false

      t.timestamps
    end
  end
end
