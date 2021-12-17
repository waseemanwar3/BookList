class CreateBook < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, default: 0.0
      t.string :tags, array:true, default: [].to_yaml

      t.timestamps
    end
  end
end
