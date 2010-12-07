class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :file_file_name
      t.string :file_file_size
      t.string :file_content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
