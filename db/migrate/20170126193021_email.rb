class Email < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.integer :guid
      t.string :from
      t.string :to
      t.string :subject
      t.datetime :date
    end
  end
  def self.down
  end
end
