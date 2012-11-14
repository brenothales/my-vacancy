class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :email
      t.text :content
      t.references :announcement
      t.boolean :situation, :default => false

      t.timestamps
    end
  end
end
