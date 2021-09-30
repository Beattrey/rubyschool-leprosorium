class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true
      t.text :name
      t.text :comment
      t.timestamps
    end
  end
end
