class CreateScenarios < ActiveRecord::Migration
  def self.up
    create_table :scenarios do |t|
      t.integer :feature_id
      t.string :name
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :scenarios
  end
end
