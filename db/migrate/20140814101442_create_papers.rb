class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.string :name
      t.string :runame
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :papers
  end
end
