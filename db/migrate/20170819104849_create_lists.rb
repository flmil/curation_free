class CreateLists < ActiveRecord::Migration[5.1]
  def change
		create_table :lists do |t|
			t.references :user
			t.string :name
			t.string :url
			t.string :image
			t.string :money
			t.string :site
			t.timestamps null: false
		end
  end
end
