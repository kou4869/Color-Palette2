class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.references :user,    foreign_key: true
      t.string :color_one,   null: false
      t.string :color_two,   null: false
      t.string :color_three, null: false
      t.string :color_four,  null: false
      t.text :post_introduction

      t.timestamps
    end
  end
end
