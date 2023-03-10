class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.references :user,    foreign_key: true
      t.string :color1,   null: false
      t.string :color2,   null: false
      t.string :color3,   null: false
      t.string :color4,   null: false
      t.text :post_introduction

      t.timestamps
    end
  end
end
