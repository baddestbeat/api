class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.string :path
      t.timestamps null: false
    end
  end
end
