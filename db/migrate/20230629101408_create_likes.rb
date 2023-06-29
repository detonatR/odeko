class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.string :user
      t.string :ffid

      t.timestamps
    end

    add_index :likes, [:user, :post_id], unique: true
  end
end
